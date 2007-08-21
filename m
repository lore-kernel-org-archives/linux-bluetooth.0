Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <8de6c3e20708211525s36ee4379ieb4a1007ee3614a8@mail.gmail.com>
Date: Tue, 21 Aug 2007 15:25:04 -0700
From: "Jeffrey Cuenco" <jcuenco@gmail.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <8de6c3e20708211521j67b4c680gbf23ae27acf1a8d2@mail.gmail.com>
MIME-Version: 1.0
References: <8de6c3e20708211521j67b4c680gbf23ae27acf1a8d2@mail.gmail.com>
Subject: [Bluez-users] Simultaneous hci_read_remote_name() requests on
	multiple dongles lead to btnames getting mapped to the wrong
	btaddr's
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0417924684=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0417924684==
Content-Type: multipart/alternative;
	boundary="----=_Part_51234_8422765.1187735104682"

------=_Part_51234_8422765.1187735104682
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

     I posted a thread about this in bluez-devel, but realized this is more
of a user-related question so I've posted it here.  I've searched through
the archives and with the exception of one thread which came close to my
problem, didn't seem to find anything else related towards
hci_read_remote_name() sometimes reporting back incorrect names.

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
was my problem, I decided to try the following modifications to hci.c; I
made the bdaddr pointer non-const in all functions used by
hci_read_remote_name() and made the small change below assuming that if the
wrong name came into rn.name , the wrong bdaddr must be stored in rn.bdaddr as
well:

    // makes sure received name's bdaddr matches what we're expecting
    bacpy(bdaddr, &rn.bdaddr);

I placed this line right above the

    strncpy(name, (char *) rn.name, len);


line near the end of the function.  After doing this, things seemed to
improve.  However, I noticed that usually after a few hours of running the
scanner software hcid would accumulate in CPU time:

USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root      1838  0.8  0.3   1960   784 ?        Ss   04:01   2:55
/usr/sbin/hcid

and when this happened the frequency of name errors recurred even with the
patch I did, and eventually the dongles would stop scanning altogether.

We've tried everything from resetting the dongles right after a name request
times out, to having the sniffer boxes reboot after a few hours, which is
something that we really don't want to do as it prevents us from gathering
data at certain intervals during the day.

As far as I can see the code shouldn't cause any problems, though I find it
strange that we have to reset the dongles at all, yet even with the reset
they eventually freeze up anyway; it's just a matter of time.  The dongles
that we are using are Belkin F8T013.  We are trying to get some CSR dongles
instead but at this point in time the Belkin's are what we have available to
us.

Is there a problem with using multiple dongles in this manner that our
software is using them?  We would like to use the multiple-dongle approach
so that the names come in faster, but if the names keep coming in
incorrectly then our data can't use the name data reliably.  Is there a bug
at the kernel level where the name requests could get mixed up if too many
name requests are happening at the same time with multiple dongles?  Is it a
Broadcom chipset-specific problem?

As an update, today there managed to be a lot of new people in the building,
which resulted in lots of new data.  Unfortunately the name problem happened
again, and even worse; almost every name that came in went to a different
btaddr, leading to our database storing incorrect names with other
btaddr's.  With a ps aux at the terminal I found that this time, the hcid
wasn't even high in CPU time, which tells me that Avaited's suspicion may
still be the case; that multiple hci_read_remote_name requests in general
are the source of the the names getting mixed up?

I apologize that this message has gotten long enough already, but I've tried
to work on this problem for weeks and am hoping that someone could clue me
in as to whether or not I'm doing something wrong, and/or if indeed there is
a BlueZ bug regarding this manner.

Thanks in advance,

-- 
-Jeff

------=_Part_51234_8422765.1187735104682
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<span class="gmail_quote"></span>Hi,<br><br>&nbsp;&nbsp;&nbsp;&nbsp; I posted a thread about this in bluez-devel, but realized this is more of a user-related question so I&#39;ve posted it here.&nbsp; I&#39;ve searched through the archives and with the exception of one thread which came close to my problem, didn&#39;t seem to
find anything else related towards hci_read_remote_name() sometimes
reporting back incorrect names.<br><br>As some background for my setup
and why I am doing this, I am part of a Bluetooth-related research
project at UCSD where we have built Bluetooth scanners using 4 dongles
connected to an embedded system box running Debian with the latest
&quot;Debian-stable&quot; BlueZ release in the libbluetooth2 package.
<br><br>In my program I spawn 4 threads, where each thread is
dedicated to a dongle.&nbsp; The first thread concentrates solely on
hci_inquiry and grabs addresses and stores them, the clock_offset, and
pscan_rep_mode into a queue.&nbsp; All other threads grab from the queue and
perform an hci_read_remote_name_with<div>_clock_offset() call on each address.&nbsp; 
<br><br>I used the same 25000 timeout setting as in hcitool.c, as I
discovered from experience that for some reason it isn&#39;t possible to
set it any lower without it doing weird things (why is that? Is there a
natural hardware timeout that can&#39;t be changed?)
<br><br>The main problem, however, is that sometimes I get back wrong
names; there is a LOT of bluetooth traffic in this building
(particularly tons of mac-mini&#39;s) that frequently respond back to the
scanner, and sometimes the mac mini name comes in place of the real
name of the device I am trying to query.&nbsp; This doesn&#39;t happen all the
time, however, but tends to happen when a lot of name queries are
happening simultaneously.
<br><br>I had seen a similar thread on here written by Avaited
regarding a patch that he had prepared to fix this problem; claiming
that he had found the problem in hci.c.&nbsp; As the patch hasn&#39;t surfaced
yet, and assuming that this was my problem, I decided to try the following modifications to hci.c; I made the bdaddr pointer non-const in all functions used by hci_read_remote_name() and made
the small change below assuming that if the wrong name came into <span style="font-family: courier new,monospace;"><a href="http://rn.name/" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">rn.name</a>

,</span> the wrong bdaddr must be stored in <span style="font-family: courier new,monospace;">rn.bdaddr </span>as well:<br><font size="1"><span style="font-family: courier new,monospace;"><br>&nbsp;&nbsp;&nbsp; // makes sure received name&#39;s bdaddr matches what we&#39;re expecting
<br>&nbsp;&nbsp;&nbsp; <span style="background-color: rgb(255, 0, 0);">bacpy(bdaddr, &amp;rn.bdaddr);</span><br><br></span></font><font size="1"><font size="2">I placed this line right above the<br><br></font></font><font size="1"><span style="font-family: courier new,monospace;">


&nbsp;&nbsp;&nbsp; strncpy(name, (char *) <a href="http://rn.name/" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">rn.name</a>, len);<br><br><br></span></font>line near the end of the function.&nbsp; After doing this, things seemed to improve.&nbsp;
However, I noticed that usually after a few hours of running the
scanner software hcid would accumulate in CPU time:
<br><br>
<font size="1"><span style="font-family: courier new,monospace;">USER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PID %CPU %MEM&nbsp;&nbsp;&nbsp; VSZ&nbsp;&nbsp; RSS TTY&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; STAT START&nbsp;&nbsp; TIME COMMAND</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1838&nbsp; 0.8&nbsp; 0.3&nbsp;&nbsp; 1960&nbsp;&nbsp; 784 ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ss&nbsp;&nbsp; 04:01&nbsp;&nbsp;<span style="font-weight: bold;"> <span style="background-color: rgb(255, 0, 0);">2:55</span></span><span style="background-color: rgb(255, 255, 255); color: rgb(255, 255, 255);">


 </span>/usr/sbin/hcid</span></font><br clear="all"><br>and
when this happened the frequency of name errors recurred even with the
patch I did, and eventually the dongles would stop scanning altogether.<br><br>We&#39;ve tried everything from resetting the dongles right after a name request times out, to having the sniffer boxes reboot after a few hours, which is something that we really don&#39;t want to do as it prevents us from gathering data at certain intervals during the day.
<br><br>As
far as I can see the code shouldn&#39;t cause any problems, though I find
it strange that we have to reset the dongles at all, yet even with the
reset they eventually freeze up anyway; it&#39;s just a matter of time.&nbsp; The dongles that we are using
are Belkin F8T013.&nbsp; We are trying to get some CSR dongles instead but
at this point in time the Belkin&#39;s are what we have available to us.
<br><br>Is there a problem with using multiple dongles in this manner
that our software is using them?&nbsp; We would like to use the
multiple-dongle approach so that the names come in faster, but if the
names keep coming in incorrectly then our data can&#39;t use the name data
reliably.&nbsp; Is there a bug at the kernel level where the name requests
could get mixed up if too many name requests are happening at the same
time with multiple dongles?&nbsp;
Is it a Broadcom chipset-specific problem?<br><br>As an update, today there managed to be a lot of new people in the building, which resulted in lots of new data.&nbsp; Unfortunately the name problem happened again, and even worse; almost every name that came in went to a different btaddr, leading to our database storing incorrect names with other btaddr&#39;s.&nbsp; With a ps aux at the terminal I found that this time, the hcid wasn&#39;t even high in CPU time, which tells me that Avaited&#39;s suspicion may still be the case; that multiple hci_read_remote_name requests in general are the source of the the names getting mixed up?
<br><br>I apologize that this message has gotten long enough already,
but I&#39;ve tried to work on this problem for weeks and am hoping that someone could clue me in as to whether or not I&#39;m doing
something wrong, and/or if indeed there is a BlueZ bug regarding this
manner.
<br><br>Thanks in advance,<span></span><span class="sg"></span><br clear="all"></div><br>-- <br>-Jeff

------=_Part_51234_8422765.1187735104682--


--===============0417924684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============0417924684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0417924684==--
