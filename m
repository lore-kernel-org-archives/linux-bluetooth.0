Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <BAY111-F1767DE6A7429B539F50C6C98A70@phx.gbl>
From: "ozkan gumus" <ozkan_gumus@hotmail.com>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/html; format=flowed
Subject: [Bluez-devel] cannot " hci_create_connection "
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 19 May 2006 07:38:27 +0000

<html><div style='background-color:'><P>hi mr holtmann, </P>
<P>i have problem with hci_create_connection function at line 120. <BR>here's the code ,&nbsp; when program comes to the line&nbsp; of hci_create_connection function <BR>it always says :</P>
<P>&nbsp;#./simplescan<BR>scanning ...<BR>00:0E:6D:3F:E0:73&nbsp; ozkan<BR>Cannot create connection</P>
<P><BR>simplescan.c</P>
<P>#include &lt;stdio.h&gt;<BR>#include &lt;errno.h&gt;<BR>#include &lt;ctype.h&gt;<BR>#include &lt;fcntl.h&gt;<BR>#include &lt;unistd.h&gt;<BR>#include &lt;stdlib.h&gt;<BR>#include &lt;string.h&gt;<BR>#include &lt;getopt.h&gt;<BR>#include &lt;sys/param.h&gt;<BR>#include &lt;sys/ioctl.h&gt;<BR>#include &lt;sys/socket.h&gt;<BR>#include &lt;signal.h&gt;<BR>#include &lt;termios.h&gt;<BR>#include &lt;fcntl.h&gt;<BR>#include &lt;getopt.h&gt;<BR>#include &lt;asm/types.h&gt;<BR>#include &lt;netinet/in.h&gt;</P>
<P>#include &lt;bluetooth/bluetooth.h&gt;<BR>#include &lt;bluetooth/hci.h&gt;<BR>#include &lt;bluetooth/hci_lib.h&gt;</P>
<P>int main(int argc, char **argv)<BR>{<BR>&nbsp;&nbsp;&nbsp; inquiry_info *ii = NULL;<BR>&nbsp;&nbsp;&nbsp; int max_rsp, num_rsp;<BR>&nbsp;&nbsp;&nbsp; int dev_id, sock, len, flags;<BR>&nbsp;&nbsp;&nbsp; int i;<BR>&nbsp;&nbsp;&nbsp; char addr[19] = { 0 };<BR>&nbsp;&nbsp;&nbsp; char name[248] = { 0 };<BR>&nbsp;int measure ;</P>
<P>&nbsp;&nbsp;&nbsp; dev_id = hci_get_route(NULL);<BR>&nbsp;&nbsp;&nbsp; sock = hci_open_dev( dev_id );<BR>&nbsp;&nbsp;&nbsp; if (dev_id &lt; 0 || sock &lt; 0) {<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; perror("opening socket");<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exit(1);<BR>&nbsp;&nbsp;&nbsp; }</P>
<P>&nbsp;&nbsp;&nbsp; len&nbsp; = 8;<BR>&nbsp;&nbsp;&nbsp; max_rsp = 255;<BR>&nbsp;&nbsp;&nbsp; flags = IREQ_CACHE_FLUSH;<BR>&nbsp;&nbsp;&nbsp; ii = (inquiry_info*)malloc(max_rsp * sizeof(inquiry_info));<BR>&nbsp;&nbsp;&nbsp; printf("scanning ...\n");<BR>&nbsp;&nbsp;&nbsp; num_rsp = hci_inquiry(dev_id, len, max_rsp, NULL, &amp;ii, flags);<BR>&nbsp;&nbsp;&nbsp; if( num_rsp &lt; 0 ) perror("hci_inquiry");</P>
<P>&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; num_rsp; i++) {<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ba2str(&amp;(ii+i)-&gt;bdaddr, addr);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(name, 0, sizeof(name));<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hci_read_remote_name(sock, &amp;(ii+i)-&gt;bdaddr, sizeof(name), <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; name, 0) &lt; 0)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strcpy(name, "[unknown]");<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf("%s&nbsp; %s\n", addr, name);<BR>&nbsp;&nbsp;measure = read_rssi(&amp;(ii+i)-&gt;bdaddr);<BR>&nbsp;&nbsp;printf("the RSSI measure for %s is %d",name,measure);<BR>&nbsp;&nbsp;&nbsp; }</P>
<P>&nbsp;&nbsp;&nbsp; free( ii );<BR>&nbsp;&nbsp;&nbsp; close( sock );<BR>&nbsp;&nbsp;&nbsp; return 0;<BR>}</P>
<P><BR>static int find_conn(int s, int dev_id, long arg)<BR>{<BR>&nbsp;struct hci_conn_list_req *cl;<BR>&nbsp;struct hci_conn_info *ci;<BR>&nbsp;int i;</P>
<P>&nbsp;if (!(cl = malloc(10 * sizeof(*ci) + sizeof(*cl)))) {<BR>&nbsp;&nbsp;perror("Can't allocate memory");<BR>&nbsp;&nbsp;exit(1);<BR>&nbsp;}<BR>&nbsp;cl-&gt;dev_id = dev_id;<BR>&nbsp;cl-&gt;conn_num = 10;<BR>&nbsp;ci = cl-&gt;conn_info;</P>
<P>&nbsp;if (ioctl(s, HCIGETCONNLIST, (void*)cl)) {<BR>&nbsp;&nbsp;perror("Can't get connection list");<BR>&nbsp;&nbsp;exit(1);<BR>&nbsp;}</P>
<P>&nbsp;for (i=0; i &lt; cl-&gt;conn_num; i++, ci++)<BR>&nbsp;&nbsp;if (!bacmp((bdaddr_t *)arg, &amp;ci-&gt;bdaddr))<BR>&nbsp;&nbsp;&nbsp;return 1;<BR>&nbsp;return 0;<BR>}</P>
<P><BR>int read_rssi(char* address) {<BR>&nbsp; int cc = 0;<BR>&nbsp; int dd;<BR>&nbsp; int dev_id;<BR>&nbsp; uint16_t handle;<BR>&nbsp; struct hci_conn_info_req *cr;<BR>&nbsp; struct hci_request rq;<BR>&nbsp; read_rssi_rp rp;<BR>&nbsp; bdaddr_t bdaddr;<BR>&nbsp; <BR>&nbsp; str2ba(address, &amp;bdaddr);<BR>&nbsp; <BR>&nbsp; dev_id = hci_for_each_dev(HCI_UP, find_conn, (long) &amp;bdaddr);<BR>&nbsp; if (dev_id &lt; 0) {<BR>&nbsp;&nbsp;&nbsp; dev_id = hci_get_route(&amp;bdaddr);<BR>&nbsp;&nbsp;&nbsp; cc = 1;<BR>&nbsp; }<BR>&nbsp; if (dev_id &lt; 0) {<BR>&nbsp;&nbsp;&nbsp; printf("Device not available\n");<BR>&nbsp;&nbsp;&nbsp; exit(1);<BR>&nbsp; }<BR>&nbsp; <BR>&nbsp; dd = hci_open_dev(dev_id);<BR>&nbsp; if (dd &lt; 0) {<BR>&nbsp;&nbsp;&nbsp; printf("Cannot open device\n");<BR>&nbsp;&nbsp;&nbsp; exit(1);<BR>&nbsp; }<BR>// ***************************&nbsp;&nbsp; PROBLEM HERE 
************************* <BR>&nbsp; if (cc) {<BR>&nbsp;&nbsp;&nbsp; if (hci_create_connection(dd, &amp;bdaddr, 0x0008 | 0x0010, 0, 0, &amp;handle, 25000) &lt; 0) {<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf("Cannot create connection\n");<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; close(dd);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exit(1);<BR>&nbsp;&nbsp;&nbsp; }<BR>&nbsp; }<BR>&nbsp;// ***************************** *****************************************<BR>&nbsp; cr = malloc(sizeof(*cr) + sizeof(struct hci_conn_info));<BR>&nbsp; if (!cr) {<BR>&nbsp;&nbsp;&nbsp; printf("Could not allocate memory\n");<BR>&nbsp;&nbsp;&nbsp; exit(1);<BR>&nbsp; }<BR>&nbsp;&nbsp;&nbsp; <BR>&nbsp; bacpy(&amp;cr-&gt;bdaddr, &amp;bdaddr);<BR>&nbsp; cr-&gt;type = ACL_LINK;<BR>&nbsp; if (ioctl(dd, HCIGETCONNINFO, (unsigned long) cr) &lt; 0) {<BR>&nbsp;&nbsp;&nbsp; printf("Get connection info failed\n");<BR>&nbsp;&nbsp;&nbsp; 
exit(1);<BR>&nbsp; }<BR>&nbsp; <BR>&nbsp; memset(&amp;rq, 0, sizeof(rq));<BR>&nbsp; rq.ogf&nbsp;&nbsp;&nbsp; = OGF_STATUS_PARAM;<BR>&nbsp; rq.ocf&nbsp;&nbsp;&nbsp; = OCF_READ_RSSI;<BR>&nbsp; rq.cparam = &amp;cr-&gt;conn_info-&gt;handle;<BR>&nbsp; rq.clen&nbsp;&nbsp; = 2;<BR>&nbsp; rq.rparam = &amp;rp;<BR>&nbsp; rq.rlen&nbsp;&nbsp; = READ_RSSI_RP_SIZE;<BR>&nbsp; <BR>&nbsp; if (hci_send_req(dd, &amp;rq, 100) &lt; 0) {<BR>&nbsp;&nbsp;&nbsp; printf("Read RSSI failed\n");<BR>&nbsp;&nbsp;&nbsp; exit(1);<BR>&nbsp; }<BR>&nbsp; <BR>&nbsp; if (rp.status) {<BR>&nbsp;&nbsp;&nbsp; printf("Read RSSI returned (error) status 0x%2.2X\n", rp.status);<BR>&nbsp;&nbsp;&nbsp; exit(1);<BR>&nbsp; }<BR>&nbsp; <BR>&nbsp; if (cc) {<BR>&nbsp;&nbsp;&nbsp; hci_disconnect(dd, handle, 0x13, 10000);<BR>&nbsp; }<BR>&nbsp; <BR>&nbsp; close(dd);<BR>&nbsp; free(cr);<BR>&nbsp; printf("My RSSI is&nbsp; : %d",rp.rssi);<BR>&nbsp; return rp.rssi ;<BR>} </P>
<P>can you give me some advise to resolve this problem, ? do you think my ptype or clkoffset are false ? </P>
<P>i will be very grateful for a little help..</P>
<P>thanks,</P>
<P>&nbsp;</P>
<P>&nbsp;</P></div><br clear=all><hr> <a href="http://g.msn.com/8HMAENUS/2731??PS=47575" target="_top">Find just what you're after with the new, more precise MSN Search - try it now!</a> </html>



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
