Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <8de6c3e20708211032q5f4bd84bg562a5e7db8c507bf@mail.gmail.com>
Date: Tue, 21 Aug 2007 10:32:24 -0700
From: "Jeffrey Cuenco" <jcuenco@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] multiple dongles and hci_read_remote_name() bug?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1581806288=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1581806288==
Content-Type: multipart/alternative;
	boundary="----=_Part_48128_21523432.1187717544074"

------=_Part_48128_21523432.1187717544074
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

     I've searched through the archives and didn't seem to find anything
related towards hci_read_remote_name() sometimes reporting back incorrect
names.

As some background for my setup and why I am doing this, I am part of a
Bluetooth-related research project at UCSD where we have built Bluetooth
scanners using 4 dongles connected to an embedded system box running Debian
with the latest "Debian-stable" BlueZ release in the libbluetooth2 package.

In my program I spawn 4 threads, where each thread is dedicated to a
dongle.  The first thread concentrates solely on hci_inquiry and grabs
addresses and stores them, the clock_offset, and pscan_rep_mode into a
queue.  All other threads grab from the queue and perform an
hci_read_remote_name_with_clock_offset() call on each address.

I used the same 25000 timeout setting as in hcitool.c, as I discovered from
experience that for some reason it isn't possible to set it any lower
without it doing weird things (why is that? Is there a natural hardware
timeout that can't be changed?)

The main problem, however, is that sometimes I get back wrong names; there
is a LOT of bluetooth traffic in this building (particularly tons of
mac-mini's) that frequently respond back to the scanner, and sometimes the
mac mini name comes in place of the real name of the device I am trying to
query.  This doesn't happen all the time, however, but tends to happen when
a lot of name queries are happening simultaneously.

I had seen a similar thread on here written by Avaited regarding a patch
that he had prepared to fix this problem; claiming that he had found the
problem in hci.c.  As the patch hasn't surfaced yet, and assuming that this
was my problem, I prepared a patch of my own to attempt to fix it; I made
the bdaddr pointer non-const and made the small change below assuming that
if the wrong name came into rn.name, the wrong bdaddr must be stored in
rn.bdaddr as well:

int hci_read_remote_name_with_clock_offset(int dd, /*const*/ bdaddr_t
*bdaddr, uint8_t pscan_rep_mode, uint16_t clkoffset, int len, char *name,
int to)
{
    evt_remote_name_req_complete rn;
    remote_name_req_cp cp;
    struct hci_request rq;

    memset(&cp, 0, sizeof(cp));
    bacpy(&cp.bdaddr, bdaddr);
    cp.pscan_rep_mode = pscan_rep_mode;
    cp.clock_offset   = clkoffset;

    memset(&rq, 0, sizeof(rq));
    rq.ogf    = OGF_LINK_CTL;
    rq.ocf    = OCF_REMOTE_NAME_REQ;
    rq.cparam = &cp;
    rq.clen   = REMOTE_NAME_REQ_CP_SIZE;
    rq.event  = EVT_REMOTE_NAME_REQ_COMPLETE;
    rq.rparam = &rn;
    rq.rlen   = EVT_REMOTE_NAME_REQ_COMPLETE_SIZE;

    if (hci_send_req(dd, &rq, to) < 0)
        return -1;

    if (rn.status) {
        errno = EIO;
        return -1;
    }

    rn.name[247] = '\0';

    // makes sure received name's bdaddr matches what we're expecting
    bacpy(bdaddr, &rn.bdaddr);

    strncpy(name, (char *) rn.name, len);

    return 0;
}
After I performed this patch, things seemed to be alright for a while.
However, I noticed that usually after a few hours of running the scanner
software hcid would accumulate in CPU time:

USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root      1838  0.8  0.3   1960   784 ?        Ss   04:01   2:55
/usr/sbin/hcid

and when this happened the frequency of name errors recurred even with the
patch, and eventually the dongles would stop scanning altogether.

As this problem had happened beforehand, we tried resetting the dongles when
the remote name request were to fail:

if (hci_read_remote_name_with_clock_offset(sock, item_addr,
    pscan_repmode, time_offset, sizeof(name), name,
    (int)(m_timeout*1000)) < 0)
{
    close(sock);
    sock = scan_reset_device(dev_id);
}

where the scan_reset_device() function is below:

int scan_reset_device(int devid)
{
    int ctl;

    ctl = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
    ioctl(ctl, HCIDEVDOWN, devid);
    ioctl(ctl, HCIDEVUP, devid);
    shutdown(ctl, 2);
    close(ctl);
    return hci_open_dev(devid);
}

As far as I can see the code shouldn't cause any problems, though I find it
strange that we have to reset the dongles at all, yet even with the reset
they eventually freeze up anyway.  The dongles that we are using are Belkin
F8T013.  We are trying to get some CSR dongles instead but at this point in
time the Belkin's are what we have available to us.

Is there a problem with using multiple dongles in this manner that our
software is using them?  We would like to use the multiple-dongle approach
so that the names come in faster, but if the names keep coming in
incorrectly then our data can't use the name data reliably.  Is there a bug
at the kernel level where the name requests could get mixed up if too many
name requests are happening at the same time with multiple dongles?

I apologize that this message has gotten long enough already, but I've tried
to work on this problem for weeks and am hoping that one of the developers
could clue me in as to whether or not I'm doing something wrong, and/or if
indeed there is a BlueZ bug regarding this manner.

Thanks in advance,
-- 
-Jeff

------=_Part_48128_21523432.1187717544074
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>&nbsp;&nbsp;&nbsp;&nbsp; I&#39;ve searched through the archives and didn&#39;t seem to find anything related towards hci_read_remote_name() sometimes reporting back incorrect names.<br><br>As some background for my setup and why I am doing this, I am part of a Bluetooth-related research project at UCSD where we have built Bluetooth scanners using 4 dongles connected to an embedded system box running Debian with the latest &quot;Debian-stable&quot; BlueZ release in the libbluetooth2 package.
<br><br>In my program I spawn 4 threads, where each thread is dedicated to a dongle.&nbsp; The first thread concentrates solely on hci_inquiry and grabs addresses and stores them, the clock_offset, and pscan_rep_mode into a queue.&nbsp; All other threads grab from the queue and perform an hci_read_remote_name_with_clock_offset() call on each address.&nbsp; 
<br><br>I used the same 25000 timeout setting as in hcitool.c, as I discovered from experience that for some reason it isn&#39;t possible to set it any lower without it doing weird things (why is that? Is there a natural hardware timeout that can&#39;t be changed?)
<br><br>The main problem, however, is that sometimes I get back wrong names; there is a LOT of bluetooth traffic in this building (particularly tons of mac-mini&#39;s) that frequently respond back to the scanner, and sometimes the mac mini name comes in place of the real name of the device I am trying to query.&nbsp; This doesn&#39;t happen all the time, however, but tends to happen when a lot of name queries are happening simultaneously.
<br><br>I had seen a similar thread on here written by Avaited regarding a patch that he had prepared to fix this problem; claiming that he had found the problem in hci.c.&nbsp; As the patch hasn&#39;t surfaced yet, and assuming that this was my problem, I prepared a patch of my own to attempt to fix it; I made the bdaddr pointer non-const and made the small change below assuming that if the wrong name came into 
<span style="font-family: courier new,monospace;"><a href="http://rn.name">rn.name</a>,</span> the wrong bdaddr must be stored in <span style="font-family: courier new,monospace;">rn.bdaddr </span>as well:<br><br><font size="1">
<span style="font-family: courier new,monospace;">int hci_read_remote_name_with_clock_offset(int dd, /*const*/ bdaddr_t *bdaddr, uint8_t pscan_rep_mode, uint16_t clkoffset, int len, char *name, int to)<br>{<br>&nbsp;&nbsp;&nbsp; evt_remote_name_req_complete rn;
<br>&nbsp;&nbsp;&nbsp; remote_name_req_cp cp;<br>&nbsp;&nbsp;&nbsp; struct hci_request rq;<br><br>&nbsp;&nbsp;&nbsp; memset(&amp;cp, 0, sizeof(cp));<br>&nbsp;&nbsp;&nbsp; bacpy(&amp;cp.bdaddr, bdaddr);<br>&nbsp;&nbsp;&nbsp; cp.pscan_rep_mode = pscan_rep_mode;<br>&nbsp;&nbsp;&nbsp; cp.clock_offset&nbsp;&nbsp; = clkoffset;
<br><br>&nbsp;&nbsp;&nbsp; memset(&amp;rq, 0, sizeof(rq));<br>&nbsp;&nbsp;&nbsp; rq.ogf&nbsp;&nbsp;&nbsp; = OGF_LINK_CTL;<br>&nbsp;&nbsp;&nbsp; rq.ocf&nbsp;&nbsp;&nbsp; = OCF_REMOTE_NAME_REQ;<br>&nbsp;&nbsp;&nbsp; rq.cparam = &amp;cp;<br>&nbsp;&nbsp;&nbsp; rq.clen&nbsp;&nbsp; = REMOTE_NAME_REQ_CP_SIZE;<br>&nbsp;&nbsp;&nbsp; rq.event&nbsp; = EVT_REMOTE_NAME_REQ_COMPLETE;
<br>&nbsp;&nbsp;&nbsp; rq.rparam = &amp;rn;<br>&nbsp;&nbsp;&nbsp; rq.rlen&nbsp;&nbsp; = EVT_REMOTE_NAME_REQ_COMPLETE_SIZE;<br><br>&nbsp;&nbsp;&nbsp; if (hci_send_req(dd, &amp;rq, to) &lt; 0)<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return -1;<br><br>&nbsp;&nbsp;&nbsp; if (rn.status) {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; errno = EIO;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return -1;
<br>&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp; rn.name[247] = &#39;\0&#39;;<br><br>&nbsp;&nbsp;&nbsp; // makes sure received name&#39;s bdaddr matches what we&#39;re expecting<br>&nbsp;&nbsp;&nbsp; <span style="background-color: rgb(255, 0, 0);">bacpy(bdaddr, &amp;rn.bdaddr);</span>
<br><br>&nbsp;&nbsp;&nbsp; strncpy(name, (char *) <a href="http://rn.name">rn.name</a>, len);<br><br>&nbsp;&nbsp;&nbsp; return 0;<br>}</span></font><br>After I performed this patch, things seemed to be alright for a while.&nbsp; However, I noticed that usually after a few hours of running the scanner software hcid would accumulate in CPU time:
<br><br>
<font size="1"><span style="font-family: courier new,monospace;">USER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PID %CPU %MEM&nbsp;&nbsp;&nbsp; VSZ&nbsp;&nbsp; RSS TTY&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; STAT START&nbsp;&nbsp; TIME COMMAND</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1838&nbsp; 0.8&nbsp; 0.3&nbsp;&nbsp; 1960&nbsp;&nbsp; 784 ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ss&nbsp;&nbsp; 04:01&nbsp;&nbsp;<span style="font-weight: bold;"> <span style="background-color: rgb(255, 0, 0);">2:55</span></span><span style="background-color: rgb(255, 255, 255); color: rgb(255, 255, 255);">
 </span>/usr/sbin/hcid</span></font><br clear="all"><br>and when this happened the frequency of name errors recurred even with the patch, and eventually the dongles would stop scanning altogether.<br><br>As this problem had happened beforehand, we tried resetting the dongles when the remote name request were to fail:
<br><br><font style="font-family: courier new,monospace;" size="1">if (hci_read_remote_name_with_clock_offset(sock, item_addr,<br>&nbsp;&nbsp;&nbsp; pscan_repmode, time_offset, sizeof(name), name,<br>&nbsp;&nbsp;&nbsp; (int)(m_timeout*1000)) &lt; 0)<br>
{<br>&nbsp;&nbsp;&nbsp; close(sock);<br>&nbsp;&nbsp;&nbsp; sock = scan_reset_device(dev_id);<br>}<br></font><font size="1"><span style="font-family: courier new,monospace;"></span></font><br>where the scan_reset_device() function is below:<br><br><font style="font-family: courier new,monospace;" size="1">
int scan_reset_device(int devid)<br>{<br>&nbsp;&nbsp;&nbsp; int ctl;<br><br>&nbsp;&nbsp;&nbsp; ctl = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);<br>&nbsp;&nbsp;&nbsp; ioctl(ctl, HCIDEVDOWN, devid);<br>&nbsp;&nbsp;&nbsp; ioctl(ctl, HCIDEVUP, devid);<br>&nbsp;&nbsp;&nbsp; shutdown(ctl, 2);<br>&nbsp;&nbsp;&nbsp; close(ctl);
<br>&nbsp;&nbsp;&nbsp; return hci_open_dev(devid);<br></font><font style="font-family: courier new,monospace;" size="1">}<br></font><br>As far as I can see the code shouldn&#39;t cause any problems, though I find it strange that we have to reset the dongles at all, yet even with the reset they eventually freeze up anyway.&nbsp; The dongles that we are using are Belkin F8T013.&nbsp; We are trying to get some CSR dongles instead but at this point in time the Belkin&#39;s are what we have available to us.
<br><br>Is there a problem with using multiple dongles in this manner that our software is using them?&nbsp; We would like to use the multiple-dongle approach so that the names come in faster, but if the names keep coming in incorrectly then our data can&#39;t use the name data reliably.&nbsp; Is there a bug at the kernel level where the name requests could get mixed up if too many name requests are happening at the same time with multiple dongles?
<br><br>I apologize that this message has gotten long enough already, but I&#39;ve tried to work on this problem for weeks and am hoping that one of the developers could clue me in as to whether or not I&#39;m doing something wrong, and/or if indeed there is a BlueZ bug regarding this manner.
<br><br>Thanks in advance,<br>-- <br>-Jeff

------=_Part_48128_21523432.1187717544074--


--===============1581806288==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============1581806288==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1581806288==--
