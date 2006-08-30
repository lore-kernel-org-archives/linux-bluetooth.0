Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44F54A39.6060704@intec.ugent.be>
Date: Wed, 30 Aug 2006 10:20:09 +0200
From: Dieter Verslype <Dieter.Verslype@intec.ugent.be>
MIME-Version: 1.0
To: Bluez Developers List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Registering service / Getting data
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello list,

> The RFCOMM channel in the SDP service registration (in your case it is 11)
> should match the channel you listen on (which is 1).

Thx, Marcel, that was a pretty lame mistake, so I fixed that.

The machine I develop on runs Kubuntu 6.06 , and this runs the bleutooth serial chat service
by default (Serial Port profile).
So everytime I wanted to send data (from a scale that's sends the weight), the sender sent it to the serial chat service.
I turned this service of, and ran my own. But now the device doesn't send the data anymore, because in the SDP request
it doesn't find a service meeting the Serial Port profile (0x1101).

Here is my dump:
<hcidump>
root@laptop:/home/dvrslype# hcidump -X -V

HCI sniffer - Bluetooth packet analyzer ver 1.28
device: hci0 snap_len: 1028 filter: 0xffffffff
#INQUIRY
...
#CONNECTION
...
#
# SDP Request for 0x1101 (Serial Port Profile)
#
 > ACL data: handle 41 flags 0x02 dlen 19
    L2CAP(d): cid 0x0040 len 15 [psm 1]
        SDP SS Req: tid 0x1 len 0xa
          pat uuid-32 0x1101 (SP)
          max 40
          cont 00
#
# SDP Response: count 0 <<<<<<<=
#
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SS Rsp: tid 0x1 len 0x5
          count 0
          cont 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 41 reason 0x08
    Reason: Connection Timeout
</hcidump>

Here is my code for registering the service and listening to the right 
channel:
<c-code>
#include <bluetooth/bluetooth.h>
#include <bluetooth/rfcomm.h>
#include <bluetooth/sdp.h>
#include <bluetooth/sdp_lib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/socket.h>

sdp_session_t* register_service();

int main(int argc, char **argv)
{
    //register service in SDPd
    sdp_session_t* session = register_service();

    struct sockaddr_rc loc_addr = { 0 }, rem_addr = { 0 };
    char buf[1024] = { 0 };
    int s, client, bytes_read;
    int opt = sizeof(rem_addr);

    // allocate socket
    s = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);

    // bind socket to port 1 of the first available
    // local bluetooth adapter
    loc_addr.rc_family = AF_BLUETOOTH;
    loc_addr.rc_bdaddr = *BDADDR_ANY;
    loc_addr.rc_channel = (uint8_t) 1;
    bind(s, (struct sockaddr *)&loc_addr, sizeof(loc_addr));

    // put socket into listening mode
    listen(s, 1);

    // accept one connection
    client = accept(s, (struct sockaddr *)&rem_addr, &opt);

    ba2str( &rem_addr.rc_bdaddr, buf );
    fprintf(stderr, "accepted connection from %s\n", buf);
    memset(buf, 0, sizeof(buf));

    // read data from the client
    bytes_read = read(client, buf, sizeof(buf));
    if( bytes_read > 0 ) {
        printf("received [%s]\n", buf);
    }

    // close connection
    close(client);
    close(s);
    sdp_close(session);
    return 0;
}

sdp_session_t* register_service() {
    uint32_t service_uuid_int[] = { 0, 0, 0, 0x1101 };
    uint8_t rfcomm_channel = 11;
    const char *service_name = "Healt Monitor Service";
    const char *service_dsc = "Captures Bluetooth packages and stores in 
SQL_DB";
    const char *service_prov = "IBCN-Niko";

    uuid_t root_uuid, l2cap_uuid, rfcomm_uuid, svc_uuid;
    sdp_list_t *l2cap_list = 0,
               *rfcomm_list = 0,
               *root_list = 0,
               *proto_list = 0,
               *access_proto_list = 0;
    sdp_data_t *channel = 0, *psm = 0;

    sdp_record_t *record = sdp_record_alloc();

    // set the general service ID
    sdp_uuid128_create( &svc_uuid, &service_uuid_int );
    sdp_set_service_id( record, svc_uuid );

    // make the service record publicly browsable
    sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
    root_list = sdp_list_append(0, &root_uuid);
    sdp_set_browse_groups( record, root_list );

    // set l2cap information
    sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
    l2cap_list = sdp_list_append( 0, &l2cap_uuid );
    proto_list = sdp_list_append( 0, l2cap_list );

    // set rfcomm information
    sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
    channel = sdp_data_alloc(SDP_UINT8, &rfcomm_channel);
    rfcomm_list = sdp_list_append( 0, &rfcomm_uuid );
    sdp_list_append( rfcomm_list, channel );
    sdp_list_append( proto_list, rfcomm_list );

    // attach protocol information to service record
    access_proto_list = sdp_list_append( 0, proto_list );
    sdp_set_access_protos( record, access_proto_list );

    // set the name, provider, and description
    sdp_set_info_attr(record, service_name, service_prov, service_dsc);
       int err = 0;
    sdp_session_t *session = 0;

    // connect to the local SDP server, register the service record, and
    // disconnect
    session = sdp_connect( BDADDR_ANY, BDADDR_LOCAL, SDP_RETRY_IF_BUSY );
    err = sdp_record_register(session, record, 0);

    // cleanup
    sdp_data_free( channel );
    sdp_list_free( l2cap_list, 0 );
    sdp_list_free( rfcomm_list, 0 );
    sdp_list_free( root_list, 0 );
    sdp_list_free( access_proto_list, 0 );
    return session;
}
</c-code>

What's wrong about the service registration?
I can't seem to find out how to list it with sdptool, how does that work?

thx in advance,

Dieter

PS: Sorry about not replying to my previous mail, I wasn't subscribed to 
the list yet, now I am!

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
