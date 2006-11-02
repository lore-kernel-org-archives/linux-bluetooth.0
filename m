Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <3f5a9ba20611012228m6290f6ech41d3e7cb77fddf6d@mail.gmail.com>
Date: Thu, 2 Nov 2006 14:28:12 +0800
From: "Mingfan.Lu" <lucharse@gmail.com>
To: "Rupesh Gujare" <rupesh_gujare@rediffmail.com>,
        "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20061102043906.3875.qmail@webmail31.rediffmail.com>
MIME-Version: 1.0
References: <20061102043906.3875.qmail@webmail31.rediffmail.com>
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
Content-Type: multipart/mixed; boundary="===============1921688207=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1921688207==
Content-Type: multipart/alternative;
	boundary="----=_Part_458_10826475.1162448892669"

------=_Part_458_10826475.1162448892669
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
  What is your kernel version and Have you patch the latest bluez-patch ?.
  I think it is the problem of currency connections. There are many
discussions about it in the maillist. From patch-linux-2.6.18-mh4
  The problem seems to be solved.


2 Nov 2006 04:39:06 -0000, Rupesh Gujare <rupesh_gujare@rediffmail.com>:
>
> Hello all,
>     I am a newbie to bluez programming. and i am currently writing a code
> that will discover all nearby bluetooth devices and make a SDP enquiry to
> know on which channel "OBEX Object Push" service is running.
>   For this purpose i have gone through a quiet a few documentation and
> sample code. And i am ready with some code.
>
>   Now my question is why it is required to give a "sleep(1)" call before
> sdp_connect() call? If i dont give it, sdp connection simply fails. And how
> should i reduce over all time of making discovery of devices and connecting
> to their respective SDP servers.
>   I am using USB dongle as a local bluetooth device.
>
>   Can someone help me on this issues? And how can i write better and
> efficient code?
> Any reviews and suggestions for improvement r welcomed.
> Any help will be greatly appreciated.
> Thanks in advance
> Rupesh..
>
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
>        port_search(&(ii+i)->bdaddr);
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
>      printf("Target blue addr is %s\n",addr);
>      //str2ba( addr, &target );
>     // connect to the SDP server running on the remote machine
>
>       ba2str(&local_addr, addr);
>       printf("Local address is %s\n",addr);
>        sleep(1);
>       session = sdp_connect( BDADDR_ANY, target,SDP_RETRY_IF_BUSY);
>      if (session==NULL)
>      {
>           printf("Can not connect to SDP server\n");
>           return -1;
>      }
>     sdp_uuid16_create( &svc_uuid, svc_uuid_int );
>     search_list = sdp_list_append( 0, &svc_uuid );
>     attrid_list = sdp_list_append( 0, &range );
>     // get a list of service records that have UUID 0xabcd
>     response_list = NULL;
>
>   status = sdp_service_search_attr_req( session, search_list,
> SDP_ATTR_REQ_RANGE, attrid_list, &response_list);
>   if( status == 0 ) {
>             if(response_list==NULL)
>             {
>                  printf("Object Push Service not found\n");
>                  return -1;
>             }
>        sdp_list_t *proto_list;
>       sdp_list_t *r = response_list;
>       // go through each of the service records
>       for (; r; r = r->next ) {
>           sdp_record_t *rec = (sdp_record_t*) r->data;
>           // get a list of the protocol sequences
>           if( sdp_get_access_protos( rec, &proto_list ) == 0 )
>            //    if(sdp_get_profile_descs(rec,&proto_list)==0)
>             {
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
>
>
> <http://adworks.rediff.com/cgi-bin/AdWorks/sigclick.cgi/www.rediff.com/signature-home.htm/1507191490@Middle5?PARTNER=3>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job
> easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
>
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>
>


-- 
With respects,
   Mingfan.Lu

------=_Part_458_10826475.1162448892669
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi,</div>
<div>&nbsp; What is your kernel version and Have you patch the latest bluez-patch ?.</div>
<div>&nbsp; I think it is the problem of currency connections. There are many discussions about it in the maillist. From patch-linux-2.6.18-mh4</div>
<div>&nbsp; The problem seems to be solved.<br><br>&nbsp;</div>
<div><span class="gmail_quote">2 Nov 2006 04:39:06 -0000, Rupesh Gujare &lt;<a href="mailto:rupesh_gujare@rediffmail.com">rupesh_gujare@rediffmail.com</a>&gt;:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<p>Hello all,<br>&nbsp; &nbsp; I am a newbie to bluez programming. and i am currently writing a code that will discover all nearby bluetooth devices and make a SDP enquiry to know on which channel &quot;OBEX Object Push&quot; service is running.
<br>&nbsp; For this purpose i have gone through a quiet a few documentation and sample code. And i am ready with some code.<br>&nbsp; &nbsp; <br>&nbsp; Now my question is why it is required to give a &quot;sleep(1)&quot; call before sdp_connect() call? If i dont give it, sdp connection simply fails. And how should i reduce over all time of making discovery of devices and connecting to their respective SDP servers.
<br>&nbsp; I am using USB dongle as a local bluetooth device.<br><br>&nbsp; Can someone help me on this issues? And how can i write better and efficient code?<br>Any reviews and suggestions for improvement r welcomed.<br>Any help will be greatly appreciated.
<br>Thanks in advance <br>Rupesh..<br><br>My code :----<br><br>#include &lt;stdio.h&gt;<br>#include &lt;stdlib.h&gt;<br>#include &lt;unistd.h&gt;<br>#include &lt;sys/socket.h&gt;<br>#include &lt;bluetooth/bluetooth.h&gt;<br>
#include &lt;bluetooth/hci.h&gt;<br>#include &lt;bluetooth/hci_lib.h&gt;<br>#include &lt;bluetooth/sdp.h&gt;<br>#include &lt;bluetooth/sdp_lib.h&gt;<br><br>int port_search(bdaddr_t *target);<br><br>int main(int argc, char **argv)
<br>{<br>&nbsp; &nbsp; inquiry_info *ii = NULL;<br>&nbsp; &nbsp; int max_rsp, num_rsp;<br>&nbsp; &nbsp; int dev_id, sock, len, flags;<br>&nbsp; &nbsp; int i;<br>&nbsp; &nbsp; char addr[19] = { 0 };<br>&nbsp; &nbsp; char name[248] = { 0 };<br>&nbsp; &nbsp; dev_id = hci_get_route(NULL);<br>&nbsp; &nbsp; sock = hci_open_dev( dev_id );
<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <br>&nbsp; if (dev_id &lt; 0 || sock &lt; 0) {<br>&nbsp; &nbsp; &nbsp; perror(&quot;opening socket&quot;);<br>&nbsp; &nbsp; &nbsp; exit(1);<br>&nbsp; }<br>&nbsp; len = 8;<br>&nbsp; max_rsp = 255;<br>&nbsp; flags = IREQ_CACHE_FLUSH;<br>&nbsp; ii = (inquiry_info*)malloc(max_rsp * sizeof(inquiry_info));
<br>&nbsp; num_rsp = hci_inquiry(dev_id, len, max_rsp, NULL, &amp;ii, flags);<br>&nbsp; printf(&quot;%d Blue devices found\n&quot;,num_rsp);<br>&nbsp; if( num_rsp &lt; 0 ) perror(&quot;hci_inquiry&quot;);<br>&nbsp; for (i = 0; i &lt; num_rsp; i++) {
<br>&nbsp; &nbsp; &nbsp; ba2str(&amp;(ii+i)-&gt;bdaddr, addr);<br>&nbsp; &nbsp; &nbsp; memset(name, 0, sizeof(name));<br>&nbsp; &nbsp; &nbsp; if (hci_read_remote_name(sock, &amp;(ii+i)-&gt;bdaddr, sizeof(name),<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; name, 0) &lt; 0)<br>&nbsp; &nbsp; &nbsp; strcpy(name, &quot;[unknown]&quot;);
<br>&nbsp; &nbsp; &nbsp; printf(&quot;%s %s\n&quot;, addr, name);<br>&nbsp; &nbsp; &nbsp;&nbsp; port_search(&amp;(ii+i)-&gt;bdaddr);<br>&nbsp; }<br>&nbsp; free( ii );<br>&nbsp; close( sock );<br>&nbsp; return 0;<br>}<br><br><br><br><br>int port_search(bdaddr_t *target)<br>{<br>
&nbsp; &nbsp; uint16_t svc_uuid_int = 0x1105;<br>&nbsp; &nbsp; int status;<br>&nbsp; &nbsp; char addr[18];<br>&nbsp; &nbsp; bdaddr_t local_addr;<br>&nbsp; &nbsp; uuid_t svc_uuid;<br>&nbsp; &nbsp; sdp_list_t *response_list, *search_list, *attrid_list;<br>&nbsp; &nbsp; sdp_session_t *session = 0;
<br>&nbsp; &nbsp; uint32_t range = 0x0000ffff;<br>&nbsp; &nbsp; uint8_t port = 0;<br><br>&nbsp; &nbsp; ba2str(target,addr);<br>&nbsp; &nbsp; &nbsp;printf(&quot;Target blue addr is %s\n&quot;,addr);<br>&nbsp; &nbsp; &nbsp;//str2ba( addr, &amp;target );<br>&nbsp; &nbsp; // connect to the SDP server running on the remote machine
<br>&nbsp; &nbsp; &nbsp; <br>&nbsp; &nbsp; &nbsp; ba2str(&amp;local_addr, addr);<br>&nbsp; &nbsp; &nbsp; printf(&quot;Local address is %s\n&quot;,addr);&nbsp; <br>&nbsp; &nbsp; &nbsp;&nbsp; sleep(1);<br>&nbsp; &nbsp; &nbsp; session = sdp_connect( BDADDR_ANY, target,SDP_RETRY_IF_BUSY);<br>&nbsp; &nbsp; &nbsp;if (session==NULL)
<br>&nbsp; &nbsp; &nbsp;{<br>&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;printf(&quot;Can not connect to SDP server\n&quot;);<br>&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;return -1;<br>&nbsp; &nbsp; &nbsp;}<br>&nbsp; &nbsp; sdp_uuid16_create( &amp;svc_uuid, svc_uuid_int );<br>&nbsp; &nbsp; search_list = sdp_list_append( 0, &amp;svc_uuid );
<br>&nbsp; &nbsp; attrid_list = sdp_list_append( 0, &amp;range );<br>&nbsp; &nbsp; // get a list of service records that have UUID 0xabcd<br>&nbsp; &nbsp; response_list = NULL;<br><br>&nbsp; status = sdp_service_search_attr_req( session, search_list, SDP_ATTR_REQ_RANGE, attrid_list, &amp;response_list);
<br>&nbsp; if( status == 0 ) {<br>&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; if(response_list==NULL)<br>&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; {&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; <br>&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;printf(&quot;Object Push Service not found\n&quot;);<br>&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;return -1;<br>&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; }<br>&nbsp; &nbsp; &nbsp;&nbsp; sdp_list_t *proto_list;
<br>&nbsp; &nbsp; &nbsp; sdp_list_t *r = response_list;<br>&nbsp; &nbsp; &nbsp; // go through each of the service records<br>&nbsp; &nbsp; &nbsp; for (; r; r = r-&gt;next ) {<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; sdp_record_t *rec = (sdp_record_t*) r-&gt;data;<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; // get a list of the protocol sequences
<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if( sdp_get_access_protos( rec, &amp;proto_list ) == 0 ) <br>&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; //&nbsp; &nbsp; if(sdp_get_profile_descs(rec,&amp;proto_list)==0)<br>&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; {<br>&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; <br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; // get the RFCOMM port number<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; port = sdp_get_proto_port( proto_list, RFCOMM_UUID );<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; sdp_list_free( proto_list, 0 );<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; sdp_record_free( rec );<br>&nbsp; &nbsp; &nbsp; }<br>&nbsp; }<br>&nbsp; sdp_list_free( response_list, 0 );
<br>&nbsp; sdp_list_free( search_list, 0 );<br>&nbsp; sdp_list_free( attrid_list, 0 );<br>&nbsp; sdp_close( session );<br>&nbsp; if( port != 0 ) {<br>&nbsp; &nbsp; &nbsp; printf(&quot;found service running on RFCOMM port %d\n&quot;, port);<br>&nbsp; }<br>&nbsp; return 0;
<br>}<br></p><br><br><a onclick="return top.js.OpenExtLink(window,event,this)" href="http://adworks.rediff.com/cgi-bin/AdWorks/sigclick.cgi/www.rediff.com/signature-home.htm/1507191490@Middle5?PARTNER=3" target="_blank"><img hspace="0" border="0">
</a> <br>-------------------------------------------------------------------------<br>Using Tomcat but need to do more? Need to support web services, security?<br>Get stuff done quickly with pre-integrated technology to make your job easier
<br>Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642" target="_blank">
http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642</a><br><br>_______________________________________________<br>Bluez-devel mailing list<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:Bluez-devel@lists.sourceforge.net">
Bluez-devel@lists.sourceforge.net</a><br><a onclick="return top.js.OpenExtLink(window,event,this)" href="https://lists.sourceforge.net/lists/listinfo/bluez-devel" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-devel
</a><br><br><br></blockquote></div><br><br clear="all"><br>-- <br>With respects,<br>&nbsp;&nbsp; Mingfan.Lu 

------=_Part_458_10826475.1162448892669--


--===============1921688207==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1921688207==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1921688207==--
