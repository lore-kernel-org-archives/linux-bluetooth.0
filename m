Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Thu, 2 Nov 2006 10:58:27 +0100 (CET)
From: Peter Wippich <pewi@gw-instruments.de>
To: Rupesh Gujare <rupesh_gujare@rediffmail.com>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20061102043906.3875.qmail@webmail31.rediffmail.com>
Message-ID: <Pine.LNX.4.63.0611021046420.16704@redbean.intranet.gw-instruments.de>
References: <20061102043906.3875.qmail@webmail31.rediffmail.com>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] Need Help In SDP Programming......
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


Hello Rupesh, 

On Thu, 2 Nov 2006, Rupesh Gujare wrote:

> Hello all,
>     I am a newbie to bluez programming. and i am currently writing a code that will discover all nearby bluetooth devices and make a SDP enquiry to know on which channel "OBEX Object Push" service is running.
>    For this purpose i have gone through a quiet a few documentation and sample code. And i am ready with some code.
>     
>    Now my question is why it is required to give a "sleep(1)" call before sdp_connect() call? If i dont give it, sdp connection simply fails. And how should i reduce over all time of making discovery of devices and connecting to their respective SDP servers.
>   I am using USB dongle as a local bluetooth device.
> 
>   Can someone help me on this issues? And how can i write better and efficient code?
> Any reviews and suggestions for improvement r welcomed.
>  Any help will be greatly appreciated.
> Thanks in advance 
> Rupesh..

I think the sleep(..) call causes a reschedule and allows the sdpd to 
finish some internal cleanup or so after a close. I got some similar 
behaviour even when connecting to the local sdp data base. 

To get your code a little bit faster you should not use the hci_inquiry() 
call. This does not only do the inquiry but also does a name request which 
requires a baseband connection to the remote device. It is much more 
efficient to do the name request as a part of the sdp request if you make 
the sdp request anyway (only one baseband connection for each device). 

Further, because most BT chips today allow for inquirie to run in the 
background, you can try to start SDP requests once you receive the BT 
address for a device and not when the inquiry is finished. However, this 
would require some much more complicated code and direct HCI socket 
programming. You may have a look at hcid to get an idea. 

Ciao, 

Peter 

> My code :----
> 
> #include <stdio.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <sys/socket.h>
> #include <bluetooth/bluetooth.h>
> #include <bluetooth/hci.h>
> #include <bluetooth/hci_lib.h>
> #include <bluetooth/sdp.h>
> #include <bluetooth/sdp_lib.h>
> 
> int port_search(bdaddr_t *target);
> 
> int main(int argc, char **argv)
> {
>     inquiry_info *ii = NULL;
>     int max_rsp, num_rsp;
>     int dev_id, sock, len, flags;
>     int i;
>     char addr[19] = { 0 };
>     char name[248] = { 0 };
>     dev_id = hci_get_route(NULL);
>     sock = hci_open_dev( dev_id );
>                                    
>   if (dev_id < 0 || sock < 0) {
>       perror("opening socket");
>       exit(1);
>   }
>   len = 8;
>   max_rsp = 255;
>   flags = IREQ_CACHE_FLUSH;
>   ii = (inquiry_info*)malloc(max_rsp * sizeof(inquiry_info));
>   num_rsp = hci_inquiry(dev_id, len, max_rsp, NULL, &ii, flags);
>   printf("%d Blue devices found\n",num_rsp);
>   if( num_rsp < 0 ) perror("hci_inquiry");
>   for (i = 0; i < num_rsp; i++) {
>       ba2str(&(ii+i)->bdaddr, addr);
>       memset(name, 0, sizeof(name));
>       if (hci_read_remote_name(sock, &(ii+i)->bdaddr, sizeof(name),
>           name, 0) < 0)
>       strcpy(name, "[unknown]");
>       printf("%s %s\n", addr, name);
> 	  port_search(&(ii+i)->bdaddr);
>   }
>   free( ii );
>   close( sock );
>   return 0;
> }
> 
> 
> 
> 
> int port_search(bdaddr_t *target)
> {
>     uint16_t svc_uuid_int = 0x1105;
>     int status;
>     char addr[18];
>     bdaddr_t local_addr;
>     uuid_t svc_uuid;
>     sdp_list_t *response_list, *search_list, *attrid_list;
>     sdp_session_t *session = 0;
>     uint32_t range = 0x0000ffff;
>     uint8_t port = 0;
> 
>     ba2str(target,addr);
> 	printf("Target blue addr is %s\n",addr);
> 	//str2ba( addr, &target );
>     // connect to the SDP server running on the remote machine
>       
>       ba2str(&local_addr, addr);
>       printf("Local address is %s\n",addr);  
> 	  sleep(1);
>       session = sdp_connect( BDADDR_ANY, target,SDP_RETRY_IF_BUSY);
> 	if (session==NULL)
> 	{
> 		printf("Can not connect to SDP server\n");
> 		return -1;
> 	}
>     sdp_uuid16_create( &svc_uuid, svc_uuid_int );
>     search_list = sdp_list_append( 0, &svc_uuid );
>     attrid_list = sdp_list_append( 0, &range );
>     // get a list of service records that have UUID 0xabcd
>     response_list = NULL;
> 
>   status = sdp_service_search_attr_req( session, search_list, SDP_ATTR_REQ_RANGE, attrid_list, &response_list);
>   if( status == 0 ) {
> 		  if(response_list==NULL)
> 		  {	      
> 		  	printf("Object Push Service not found\n");
> 		  	return -1;
> 		  }
> 	  sdp_list_t *proto_list;
>       sdp_list_t *r = response_list;
>       // go through each of the service records
>       for (; r; r = r->next ) {
>           sdp_record_t *rec = (sdp_record_t*) r->data;
>           // get a list of the protocol sequences
>           if( sdp_get_access_protos( rec, &proto_list ) == 0 ) 
> 		 //    if(sdp_get_profile_descs(rec,&proto_list)==0)
> 		  {
> 		 
>               // get the RFCOMM port number
>               port = sdp_get_proto_port( proto_list, RFCOMM_UUID );
>               sdp_list_free( proto_list, 0 );
>           }
>           sdp_record_free( rec );
>       }
>   }
>   sdp_list_free( response_list, 0 );
>   sdp_list_free( search_list, 0 );
>   sdp_list_free( attrid_list, 0 );
>   sdp_close( session );
>   if( port != 0 ) {
>       printf("found service running on RFCOMM port %d\n", port);
>   }
>   return 0;
> }
> 


|       Peter Wippich                   Voice: +49 30 46776411          |
|       G&W Instruments GmbH            fax:   +49 30 46776419          |
|       Gustav-Meyer-Allee 25, Geb. 12  Email: pewi@gw-instruments.de   |
|       D-13355 Berlin  / Germany                                       |


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
