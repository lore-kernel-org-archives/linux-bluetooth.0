Return-Path: <cyrus@holtmann.org>
Date: Thu, 6 Mar 2008 08:49:14 -0800 (PST)
From: binta sidibe <sidibebinta@yahoo.com>
Reply-To: sidibebinta@yahoo.com
Subject: SDP discovery not working 
To: "marcel@holtmann.org" <marcel@holtmann.org>
Cc: "bluez-users@lists.sourceforge.net" <bluez-users@lists.sourceforge.net>,
  bintasidibeh@hotmail.com
MIME-Version: 1.0
Content-Type: text/html; charset=us-ascii
Message-ID: <66945.28299.qm@web57404.mail.re1.yahoo.com>
List-ID: <bluez-users.lists.sourceforge.net>

<table cellspacing='0' cellpadding='0' border='0' ><tr><td style='font: inherit;'><P>hello,</P>
<P>i need help with my bluetooth project. i have two boards TS7300 and i have attached Dlink DT-120 on both. For my project, one is the server and the other is the client. i want to have sevices offered by my server so that my client can just connect to my servers SDP server to get the port numbers.&nbsp;When i&nbsp;hard code the port number i am using, my client&nbsp;can send message to my&nbsp;service...good. Now i&nbsp;went a step ahead and tried to register&nbsp;a service on my server but it fails to connect to local sdp server.&nbsp;</P>
<P>On my server board...</P>
<P><A href="mailto:root@ts7000:root">root@ts7000:root</A># uname -r<BR>2.4.26-ts11</P>
<P><A href="mailto:root@ts7000:root">root@ts7000:root</A># modprobe bluez<BR><A href="mailto:root@ts7000:root">root@ts7000:root</A># lsmod<BR>Module&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Size&nbsp; Used by&nbsp;&nbsp;&nbsp; Not tainted<BR>rfcomm&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 31296&nbsp;&nbsp; 0&nbsp; (unused)<BR>l2cap&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 15676&nbsp;&nbsp; 1&nbsp; [rfcomm]<BR>hci_usb&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8144&nbsp;&nbsp; 0&nbsp; (unused)<BR>bluez&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 30428&nbsp;&nbsp; 1&nbsp; [rfcomm l2cap
 hci_usb]<BR>af_packet&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9456&nbsp;&nbsp; 0&nbsp; (unused)<BR>zd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 264068&nbsp;&nbsp; 0&nbsp; (unused)<BR>open_eth&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4448&nbsp;&nbsp; 0&nbsp; (unused)<BR>tsuart-73&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1380&nbsp;&nbsp; 0&nbsp; (unused)<BR>tsuart0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9128&nbsp;&nbsp; 0&nbsp; [tsuart-73]<BR>keybdev&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1772&nbsp;&nbsp; 0&nbsp;
 (unused)<BR>hid&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 13520&nbsp;&nbsp; 0&nbsp; (unused)<BR>input&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3320&nbsp;&nbsp; 0&nbsp; [keybdev hid]<BR>usb-ohci-ep93xx&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 632&nbsp;&nbsp; 0&nbsp; (unused)<BR>usb-ohci&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 15360&nbsp;&nbsp; 0&nbsp; [usb-ohci-ep93xx]<BR>usbcore&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 55728&nbsp;&nbsp; 1&nbsp; [hci_usb zd hid usb-ohci]<BR>pcipool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1888&nbsp;&nbsp; 1&nbsp; [usb-ohci-ep93xx
 usb-ohci]<BR>ts7300fb&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3944&nbsp; 63</P>
<P>&nbsp;</P>
<P><A href="mailto:root@ts7000:root">root@ts7000:root</A># hciconfig hci0 up<BR><A href="mailto:root@ts7000:root">root@ts7000:root</A># hciconfig<BR>hci0:&nbsp;&nbsp; Type: USB<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:17:9A:2B:86:8A ACL MTU: 384:8&nbsp; SCO MTU: 64:8<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:63 acl:0 sco:0 events:7 errors:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:27 acl:0 sco:0 commands:7 errors:0</P>
<P>&nbsp;</P>
<P><A href="mailto:root@ts7000:root">root@ts7000:root</A># sdptool browse 00:17:9A:2B:86:8A<BR>Failed to connect to SDP server on 00:17:9A:2B:86:8A: No route to host</P>
<P>&nbsp;</P>
<P>&nbsp;</P>
<P>The code that i am using is based on online website. the code is below</P>
<P>&nbsp;</P>
<P>#include &lt;stdio.h&gt;<BR>#include &lt;stdlib.h&gt;<BR>#include &lt;errno.h&gt;<BR>#include &lt;unistd.h&gt;<BR>#include &lt;sys/socket.h&gt;<BR>#include &lt;/opt/bluetooth/bluetooth.h&gt;<BR>#include &lt;/opt/bluetooth/rfcomm.h&gt;<BR>#include &lt;/opt/bluetooth/sdp.h&gt;<BR>#include &lt;/opt/bluetooth/sdp_lib.h&gt;</P>
<P>&nbsp;</P>
<P>sdp_session_t* register_service()<BR>{<BR>&nbsp;&nbsp;&nbsp; uint8_t svc_uuid_int[] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0, 0, 0xab, 0xcd };<BR>&nbsp;&nbsp;&nbsp;&nbsp; bdaddr_t target;<BR>&nbsp;&nbsp;&nbsp;&nbsp; char local[18] = "00:17:9A:2B:86:8A";<BR>&nbsp;&nbsp;&nbsp;&nbsp; str2ba(local, &amp;target);<BR>&nbsp;&nbsp;&nbsp;&nbsp; int err = 0, port =0;</P>
<P>&nbsp;<BR>&nbsp;&nbsp;&nbsp; uint8_t rfcomm_channel = 11;<BR>&nbsp;&nbsp;&nbsp; const char *service_name = "Bluetooth Taillight";<BR>&nbsp;&nbsp;&nbsp; const char *svc_dsc = "An experimental wireless taillight system";<BR>&nbsp;&nbsp;&nbsp; const char *service_prov = "Wireless Taillight";</P>
<P>&nbsp;&nbsp;&nbsp; uuid_t root_uuid, l2cap_uuid, rfcomm_uuid, svc_uuid, <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svc_class_uuid;<BR>&nbsp;&nbsp;&nbsp; sdp_list_t *l2cap_list = 0, <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *rfcomm_list = 0,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *root_list = 0,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *proto_list = 0, <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *access_proto_list = 0;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //*svc_class_list = 0,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //*profile_list = 0;<BR>&nbsp;&nbsp;&nbsp; sdp_data_t *channel = 0, *psm = 0;<BR>&nbsp;&nbsp;&nbsp; printf("Inside registering for
 service after initiation \n\n");</P>
<P><BR>&nbsp;&nbsp;&nbsp; //sdp_profile_desc_t profile;<BR>&nbsp;&nbsp;&nbsp; sdp_record_t *record = sdp_record_alloc();<BR>&nbsp;&nbsp;&nbsp; if (!record) <BR>&nbsp;&nbsp;&nbsp; {<BR>&nbsp;printf("Failed to alloc service record\n\n");<BR>&nbsp;&nbsp;&nbsp; }<BR>&nbsp;&nbsp;&nbsp; else<BR>&nbsp;&nbsp;&nbsp; {<BR>&nbsp;printf("success to alloc service record \n\n");<BR>&nbsp;&nbsp;&nbsp; }<BR>&nbsp;<BR>&nbsp;&nbsp;&nbsp; sdp_session_t *session = 0;</P>
<P>&nbsp;&nbsp;&nbsp; // set the general service ID<BR>&nbsp;&nbsp;&nbsp; sdp_uuid128_create( &amp;svc_uuid, &amp;svc_uuid_int );<BR>&nbsp;&nbsp;&nbsp; sdp_set_service_id( record, svc_uuid );<BR>&nbsp;&nbsp;&nbsp; printf("Inside registering for service after setting&nbsp; up the general service ID\n\n");</P>
<P>&nbsp;&nbsp;&nbsp; <BR>&nbsp;&nbsp;&nbsp; // make the service record publicly browsable<BR>&nbsp;&nbsp;&nbsp; sdp_uuid16_create(&amp;root_uuid, PUBLIC_BROWSE_GROUP);<BR>&nbsp;&nbsp;&nbsp; root_list = sdp_list_append(0, &amp;root_uuid);<BR>&nbsp;&nbsp;&nbsp; sdp_set_browse_groups( record, root_list );<BR>&nbsp;&nbsp;&nbsp; printf("Inside registering for service after setting up record publicly browsable\n\n");<BR>&nbsp;&nbsp;&nbsp; </P>
<P>&nbsp;&nbsp;&nbsp; // set l2cap information<BR>&nbsp;&nbsp;&nbsp; sdp_uuid16_create(&amp;l2cap_uuid, L2CAP_UUID);<BR>&nbsp;&nbsp;&nbsp; l2cap_list = sdp_list_append( 0, &amp;l2cap_uuid );<BR>&nbsp;&nbsp;&nbsp; proto_list = sdp_list_append( 0, l2cap_list );</P>
<P>&nbsp;&nbsp;&nbsp; // register the RFCOMM channel for RFCOMM sockets<BR>&nbsp;&nbsp;&nbsp; sdp_uuid16_create(&amp;rfcomm_uuid, RFCOMM_UUID);<BR>&nbsp;&nbsp;&nbsp; channel = sdp_data_alloc(SDP_UINT8, &amp;rfcomm_channel);<BR>&nbsp;&nbsp;&nbsp; rfcomm_list = sdp_list_append( 0, &amp;rfcomm_uuid );<BR>&nbsp;&nbsp;&nbsp; sdp_list_append( rfcomm_list, channel );<BR>&nbsp;&nbsp;&nbsp; sdp_list_append( proto_list, rfcomm_list );</P>
<P>&nbsp;&nbsp;&nbsp; <BR>&nbsp;&nbsp;&nbsp; // set the name, provider, and description<BR>&nbsp;&nbsp;&nbsp; sdp_set_info_attr(record, service_name, service_prov, svc_dsc);</P>
<P>&nbsp;&nbsp;&nbsp; // connect to the local SDP server, register the service record, <BR>&nbsp;&nbsp;&nbsp; // and disconnect<BR>&nbsp;&nbsp;&nbsp; //session = sdp_connect(BDADDR_ANY, BDADDR_LOCAL, SDP_RETRY_IF_BUSY);<BR>&nbsp;&nbsp;&nbsp; if (!(session = sdp_connect(BDADDR_ANY, &amp;target, SDP_RETRY_IF_BUSY)))<BR>&nbsp;&nbsp;&nbsp; {<BR>&nbsp;printf("Failed to connect to local server \n\n");<BR>&nbsp;printf("the&nbsp; value of session = %d \n", session);<BR>&nbsp;&nbsp;&nbsp; }<BR>&nbsp;&nbsp;&nbsp; else<BR>&nbsp;&nbsp;&nbsp; &nbsp;err = sdp_record_register(session, record, 0);<BR>&nbsp;&nbsp;&nbsp; //sdp_record_register(session, &amp;record, 0);</P>
<P>&nbsp;&nbsp;&nbsp; // cleanup<BR>&nbsp;&nbsp;&nbsp; sdp_data_free( channel );<BR>&nbsp;&nbsp;&nbsp; sdp_list_free( l2cap_list, 0 );<BR>&nbsp;&nbsp;&nbsp; sdp_list_free( rfcomm_list, 0 );<BR>&nbsp;&nbsp;&nbsp; sdp_list_free( root_list, 0 );<BR>&nbsp;&nbsp;&nbsp; sdp_list_free( access_proto_list, 0 );<BR>&nbsp;&nbsp;&nbsp; //sdp_list_free( svc_class_list, 0 );<BR>&nbsp;&nbsp;&nbsp; //sdp_list_free( profile_list, 0 );</P>
<P>&nbsp;&nbsp;&nbsp; return session;<BR>}</P>
<P>int main()<BR>{</P>
<P>&nbsp;&nbsp;&nbsp; sdp_session_t* session = register_service();<BR>&nbsp;&nbsp;&nbsp; printf("After register for service \n\n");<BR>&nbsp;&nbsp;&nbsp; sleep(5);<BR>&nbsp;&nbsp;&nbsp; sdp_close( session );<BR>&nbsp;&nbsp;&nbsp; return 0;<BR>}<BR></P>
<P>&nbsp;</P>
<P>when i run it, </P>
<P>&nbsp;</P>
<P><A href="mailto:root@ts7000:bluetooth">root@ts7000:bluetooth</A># gcc -o rfcomm-register rfcomm-register.c -lbluetooth<BR><A href="mailto:root@ts7000:bluetooth">root@ts7000:bluetooth</A># ./rfcomm-register<BR>Inside registering for service after initiation</P>
<P>success to alloc service record</P>
<P>Inside registering for service after setting&nbsp; up the general service ID</P>
<P>Inside registering for service after setting up record publicly browsable</P>
<P>Failed to connect to local server</P>
<P>the&nbsp; value of session = 0<BR>After register for service</P>
<P>Segmentation fault</P>
<P>&nbsp;</P>
<P>Can someone please tell me what i am doing wrong....</P>
<P>&nbsp;</P>
<P>&nbsp;</P>
<P>&nbsp;&nbsp;&nbsp;&nbsp;</P></td></tr></table><br>
      <hr size=1>Be a better friend, newshound, and 
know-it-all with Yahoo! Mobile. <a href="http://us.rd.yahoo.com/evt=51733/*http://mobile.yahoo.com/;_ylt=Ahu06i62sR8HDtDypao8Wcj9tAcJ "> Try it now.</a>
