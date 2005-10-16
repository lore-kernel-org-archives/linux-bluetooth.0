Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43526E92.1040500@ruault.com>
From: Charles-Edouard Ruault <ce@ruault.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] SEGV when searching for L2CAP port
References: <43526851.3030406@ruault.com>
In-Reply-To: <43526851.3030406@ruault.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 16 Oct 2005 17:15:30 +0200

Sorry for the noise, you can forget my question, i found the answer ....

Charles-Edouard Ruault wrote:

> Hi All,
> I'm writing an app in C on linux using the latest bluez-libs (2.2.21 ).
> The app is very simple, it's seaching for service on a device using 
> it's UUID and retrives the SDP port to be used to connect to the 
> remote service.
> I'm kind of new to bluez programming so forgive me if i'm totally off 
> tracks but here's what i'm doing :
>
>    uint32_t addlistener_uuid_int[] = { 0xAAA2689C, 0xD711C01E, 
> 0xB0006C9E, 0xEC763DD0 };
>    if (!(s = sdp_connect(src, dst, 0)))
>    {
>      printf("Failed to connect\n");
>      return ERROR;
>    }
>    sdp_uuid128_create(&svclass, &addlistener_uuid_int);
>    srch = sdp_list_append(NULL, &svclass);
>    uint32_t range = 0x0000ffff;
>    attrs = sdp_list_append( NULL, &range );
>    err = sdp_service_search_attr_req( s, srch, SDP_ATTR_REQ_RANGE, 
> attrs, &rsp);
>    sdp_close(s);
>    if (err)
>    {
>      printf("sdp_service_search_req failed : %d\n", err);
>      return ERROR;
>    }
>      sdp_list_t *r = rsp;
>    if ((r==NULL) || (r->next==NULL))
>    {
>      printf("Empty service list ...\n");
>      return -1;
>    }
>    psm=sdp_get_proto_port(rsp, L2CAP_UUID);
>
> I'm getting a SEGV in the function sdp_get_proto_port.
> I've debugged into the function and i found that sdp_get_port crashes 
> on the outlined line below because p->next does not contains a valid 
> address, it contains 0x10008 which is the service record handler of 
> the service i'm looking for.
>
> int sdp_get_proto_port(const sdp_list_t *list, int proto)
> {
>        if (proto != L2CAP_UUID && proto != RFCOMM_UUID) {
>                errno = EINVAL;
>                return -1;
>        }
>
>        for (; list; list = list->next) {
>                sdp_list_t *p;
>                for (p = list->data; p; p = p->next) {
>                        sdp_data_t *seq = (sdp_data_t *) p->data; /// 
> CRASH HERE BECAUSE p==0x10008
>                        int port = __find_port(seq, proto);
>                        if (port)
>                                return port;
>                }
>        }
>        return 0;
> }
>
> Here's what an hcidump of the transaction looks like:
>
> device: hci0 snap_len: 1028 filter: 0xffffffff
> < HCI Command: Create Connection (0x01|0x0005) plen 13
> > HCI Event: Command Status (0x0f) plen 4
> > HCI Event: Link Key Request (0x17) plen 6
> < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
> > HCI Event: Command Complete (0x0e) plen 10
> > HCI Event: Connect Complete (0x03) plen 11
> < ACL data: handle 6 flags 0x02 dlen 12
>    L2CAP(s): Connect req: psm 1 scid 0x0040
> < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> > HCI Event: Command Complete (0x0e) plen 6
> > HCI Event: Max Slots Change (0x1b) plen 3
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 6 flags 0x02 dlen 16
>    L2CAP(s): Connect rsp: dcid 0x0044 scid 0x0040 result 1 status 2
>      Connection pending - Authorization pending
> > ACL data: handle 6 flags 0x02 dlen 16
>    L2CAP(s): Connect rsp: dcid 0x0044 scid 0x0040 result 0 status 0
>      Connection successful
> < ACL data: handle 6 flags 0x02 dlen 12
>    L2CAP(s): Config req: dcid 0x0044 flags 0x00 clen 0
> > ACL data: handle 6 flags 0x02 dlen 12
>    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> < ACL data: handle 6 flags 0x02 dlen 14
>    L2CAP(s): Config rsp: scid 0x0044 flags 0x00 result 0 clen 0
>      Success
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 6 flags 0x02 dlen 14
>    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
>      Success
> < ACL data: handle 6 flags 0x02 dlen 38
>    L2CAP(d): cid 0x0044 len 34 [psm 1]
>        SDP SSA Req: tid 0x0 len 0x1d
>          pat uuid-128 9c68a2aa-1ec0-11d7-9e6c-00b0d03d76ec
>          max 65535
>          aid(s) 0x0000 - 0xffff
>          cont 00
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 6 flags 0x02 dlen 105
>    L2CAP(d): cid 0x0040 len 101 [psm 1]
>        SDP SSA Rsp: tid 0x0 len 0x60
>          count 93
>          record #0
>              aid 0x0000 (SrvRecHndl)
>                 uint 0x10008
>              aid 0x0001 (SrvClassIDList)
>                 < uuid-128 9c68a2aa-1ec0-11d7-9e6c-00b0d03d76ec >
>              aid 0x0004 (ProtocolDescList)
>                 < < uuid-16 0x0100 (L2CAP) uint 0x1001 > >
>              aid 0x0005 (BrwGrpList)
>                 uuid-16 0x1002 (PubBrwsGrp)
>              aid 0x0006 (LangBaseAttrIDList)
>                 < uint 0x656e uint 0x6a uint 0x100 >
>              aid 0x0100 (SrvName)
>                 str "AdListener"
>              aid 0x4321 (unknown)
>                 str "Coucou"
>          cont 00
> < ACL data: handle 6 flags 0x02 dlen 12
>    L2CAP(s): Disconn req: dcid 0x0044 scid 0x0040
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 6 flags 0x02 dlen 12
>    L2CAP(s): Disconn rsp: dcid 0x0044 scid 0x0040
> < HCI Command: Disconnect (0x01|0x0006) plen 3
> > HCI Event: Command Status (0x0f) plen 4
> > HCI Event: Disconn Complete (0x05) plen 4
>
> So my question is : What am i doing wrong ? What's the correct method 
> to retrive the psm to use to connect to my L2CAP service ?
> Thanks in advance.
> Regards.
>


-- 
Charles-Edouard Ruault
PGP Key ID E4D2B80C



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
