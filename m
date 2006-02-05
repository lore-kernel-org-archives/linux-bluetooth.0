Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <5bab330d0602050339w271e072btc06e632e5caff33c@mail.gmail.com>
From: Nigel Sim <nigel.sim@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] A2DP w/ Blueant headset
In-Reply-To: <43E5BAB2.5030800@xmission.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_23803_14654753.1139139556040"
References: <5bab330d0512192018o281f89a6l242586c487297e8f@mail.gmail.com>
	 <43A78D40.7070209@xmission.com>
	 <5bab330d0512201659w8af0301r7fd09cba76c6ca92@mail.gmail.com>
	 <43A9B384.5040202@xmission.com>
	 <5bab330d0602041925h53623f50h8560344f37a62d0d@mail.gmail.com>
	 <43E5BAB2.5030800@xmission.com>
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
Date: Sun, 5 Feb 2006 21:39:16 +1000

------=_Part_23803_14654753.1139139556040
Content-Type: multipart/alternative;
	boundary="----=_Part_23804_12903430.1139139556040"

------=_Part_23804_12903430.1139139556040
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Brad,

I've attached the unified diff to this message.

In regards to my new issue, it appears that the SEID is not released, and i=
s
reported as (InUse) in the hci dump (
http://hpc-external.jcu.edu.au/~nigel/uploads/Main/inuseHCIDump.txt). Even
though 'hcitool con' reports no connections. However, this problem goes awa=
y
if I reenable the code block at around a2play.c:1081 which is commened to b=
e
disabled because of problems it causes for the iTech headsets.

Many thanks

Nigel

On 2/5/06, Brad Midgley <bmidgley@xmission.com> wrote:
>
> Nigel
>
> > Brad, I've just cracked it. For some reason the avdtp_discover is not
> > returning the codec list straight away
>
> ok--very nice detective work! would you like to give me a unified diff?
> i'd like to see it coded to only retransmit when it fails in that
> specific way...
>
> thanks
> brad
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log
> files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D103432&bid=3D230486&dat=
=3D121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_23804_12903430.1139139556040
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Brad, <br><br>I've attached the unified diff to this message.<br><br>In reg=
ards to my new issue, it appears that the SEID is not released, and is repo=
rted as (InUse) in the hci dump (<a href=3D"http://hpc-external.jcu.edu.au/=
~nigel/uploads/Main/inuseHCIDump.txt">
http://hpc-external.jcu.edu.au/~nigel/uploads/Main/inuseHCIDump.txt</a>). E=
ven though 'hcitool con' reports no connections. However, this problem goes=
 away if I reenable the code block at around a2play.c:1081 which is commene=
d to be disabled because of problems it causes for the iTech headsets.
<br><br>Many thanks<br><br>Nigel<br><br><div><span class=3D"gmail_quote">On=
 2/5/06, <b class=3D"gmail_sendername">Brad Midgley</b> &lt;<a href=3D"mail=
to:bmidgley@xmission.com">bmidgley@xmission.com</a>&gt; wrote:</span><block=
quote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 2=
04); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Nigel<br><br>&gt; Brad, I've just cracked it. For some reason the avdtp_dis=
cover is not<br>&gt; returning the codec list straight away<br><br>ok--very=
 nice detective work! would you like to give me a unified diff?<br>i'd like=
 to see it coded to only retransmit when it fails in that
<br>specific way...<br><br>thanks<br>brad<br><br><br>----------------------=
---------------------------------<br>This SF.net email is sponsored by: Spl=
unk Inc. Do you grep through log files<br>for problems?&nbsp;&nbsp;Stop!&nb=
sp;&nbsp;Download the new AJAX search engine that makes
<br>searching your log files as easy as surfing the&nbsp;&nbsp;web.&nbsp;&n=
bsp;DOWNLOAD SPLUNK!<br><a href=3D"http://sel.as-us.falkag.net/sel?cmd=3Dln=
k&amp;kid=3D103432&amp;bid=3D230486&amp;dat=3D121642">http://sel.as-us.falk=
ag.net/sel?cmd=3Dlnk&amp;kid=3D103432&amp;bid=3D230486&amp;dat=3D121642
</a><br>_______________________________________________<br>Bluez-devel mail=
ing list<br><a href=3D"mailto:Bluez-devel@lists.sourceforge.net">Bluez-deve=
l@lists.sourceforge.net</a><br><a href=3D"https://lists.sourceforge.net/lis=
ts/listinfo/bluez-devel">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockquot=
e></div><br>

------=_Part_23804_12903430.1139139556040--

------=_Part_23803_14654753.1139139556040
Content-Type: text/plain; name=a2play.diff; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ejb9q5k6
Content-Disposition: attachment; filename="a2play.diff"

Index: a2play.c
===================================================================
RCS file: /cvsroot/bluetooth-alsa/btsco/a2play.c,v
retrieving revision 1.98
diff -u -r1.98 a2play.c
--- a2play.c	15 Jan 2006 22:34:45 -0000	1.98
+++ a2play.c	5 Feb 2006 11:23:28 -0000
@@ -846,6 +846,9 @@
 	}
 	else fprintf(stderr, "Sent the Stream End Point Discovery Command\n");
 	size = read(cmdfd, &get_resp, sizeof(get_resp));
+	if (size == 2 && get_resp.header.message_type == 0 && get_resp.header.packet_type == 0) 
+		// Try again if this fails once (BlueAnt headset)
+		size = read(cmdfd, &get_resp, sizeof(get_resp));
 	if (size < sizeof(get_resp) - MAX_ADDITIONAL_CODEC_OCTETS) {
 		fprintf(stderr, "couldn't get avdtp_discover (only %d bytes read)\n", size);
 		close(cmdfd);






------=_Part_23803_14654753.1139139556040--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
