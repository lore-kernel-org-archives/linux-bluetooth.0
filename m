Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <18a15270707021202o41c2e1a7id7030b8fdeaaa318@mail.gmail.com>
Date: Mon, 2 Jul 2007 20:02:15 +0100
From: "Ranulf Doswell" <ralf@ranulf.net>
To: cbe-oss-dev@ozlabs.org, bluez-devel@lists.sf.net
In-Reply-To: <1183268165.8189.9.camel@concordia.ozlabs.ibm.com>
MIME-Version: 1.0
References: <18a15270706300844t28c3aab6jb24f45453ce1557b@mail.gmail.com>
	<1183268165.8189.9.camel@concordia.ozlabs.ibm.com>
Subject: Re: [Bluez-devel] [Cbe-oss-dev] [PATCH] reset unexpected bluetooth
	data connections
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0445151919=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0445151919==
Content-Type: multipart/alternative;
	boundary="----=_Part_88042_11020312.1183402935842"

------=_Part_88042_11020312.1183402935842
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Michael,

Thanks for the info, specifically the pointers to the coding style and patch
submission rules, which I neglected to look for in my excitement to create
my first kernel patch!

 I'll repost the patch in a few minutes as I've made the comments generic
rather than sounding like a PS3-specific ptroblem.

This is one of the places you should send this patch, the other is the
> bluetooth list, which I've CC'ed. The main issue is whether your patch
> is safe in the general case, or if it's just a PS3 issue.


I haven't got a great deal of BT equipment, so it's hard to test, but my
personal opinion is that any device which sends unsolicited data should
survive having a reset sent to it, as it's not correct for it to be sending
ACL data without a valid connection established. Arguably, the same patch
should be applied when unsolicited SCO data is received, although I have no
way of testing this.

Without the patch, it doesn't make sense to syslog the invalid data as it
opens up the system to an easily exploitable DOS simply by getting within
100m of a machine and flooding it with packets from a handheld device. This
particular device was sending about 100 packets per second.

Cool, do the sixaxis controllers work with this patch applied?


Pascal's hidd patch (patch-hidd-2.24-pabr2) works well to enable the
controllers to be detected. It looks like the most important part of the
patch has already been accepted into the bluez-utils tree, although the MTU
increase part of the patch hasn't been included, so PS3 controllers still
don't work out of the box as they require a slightly larger MTU.

All this patch does is reset the controllers when the machine is rebooted as
they otherwise continue to send packets until the machine is powered down.
It seems that their timeout is about a minute and that linux's stack running
provides sufficient ACK that data is still being received even if the kernel
itself doesn't know anything about the connection.

An additional patch to send every bluetooth device a reset as the kernel is
shutting down would probably also be a good idea, although it is possible to
add "hidd --killall" to a shutdown script to achieve the same result.

Cheers,
    Ralf.

------=_Part_88042_11020312.1183402935842
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Michael,<br><br>Thanks for the info, specifically the pointers to the coding style and patch submission rules, which I neglected to look for in my excitement to create my first kernel patch!<br><br>&nbsp;I&#39;ll repost the patch in a few minutes as I&#39;ve made the comments generic rather than sounding like a PS3-specific ptroblem.
<br><br><div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">This is one of the places you should send this patch, the other is the<br>bluetooth list, which I&#39;ve CC&#39;ed. The main issue is whether your patch
<br>is safe in the general case, or if it&#39;s just a PS3 issue.</blockquote><div><br>I haven&#39;t got a great deal of BT equipment, so it&#39;s hard to test, but my personal opinion is that any device which sends unsolicited data should survive having a reset sent to it, as it&#39;s not correct for it to be sending ACL data without a valid connection established. Arguably, the same patch should be applied when unsolicited SCO data is received, although I have no way of testing this.
<br><br>Without the patch, it doesn&#39;t make sense to syslog the invalid data as it opens up the system to an easily exploitable DOS simply by getting within 100m of a machine and flooding it with packets from a handheld device. This particular device was sending about 100 packets per second.
<br><br></div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Cool, do the sixaxis controllers work with this patch applied?
</blockquote><div><br>Pascal&#39;s hidd patch (patch-hidd-2.24-pabr2) works well to enable the controllers to be detected. It looks like the most important part of the patch has already been accepted into the bluez-utils tree, although the MTU increase part of the patch hasn&#39;t been included, so PS3 controllers still don&#39;t work out of the box as they require a slightly larger MTU.
<br><br>All this patch does is reset the controllers when the machine is rebooted as they otherwise continue to send packets until the machine is powered down. It seems that their timeout is about a minute and that linux&#39;s stack running provides sufficient ACK that data is still being received even if the kernel itself doesn&#39;t know anything about the connection.
<br><br>An additional patch to send every bluetooth device a reset as the kernel is shutting down would probably also be a good idea, although it is possible to add &quot;hidd --killall&quot; to a shutdown script to achieve the same result.
<br><br></div><div>Cheers,<br>&nbsp;&nbsp;&nbsp; Ralf.</div></div><br>

------=_Part_88042_11020312.1183402935842--


--===============0445151919==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0445151919==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0445151919==--
