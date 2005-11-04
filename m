Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <ef9938ec0511041238p44299f0ay567e66e3c262cd9b@mail.gmail.com>
From: Albert Huang <ashuang@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Protocols over Bluetooth Baseband and disabiling Retransmissions
In-Reply-To: <436BBCE5.60505@masaka.cs.ohiou.edu>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_28353_5410372.1131136684283"
References: <436BBCE5.60505@masaka.cs.ohiou.edu>
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
Date: Fri, 4 Nov 2005 15:38:04 -0500

------=_Part_28353_5410372.1131136684283
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I would like to "break" the retransmission mechanism for L2CAP Packets

> (I am forced to use Java and JSR-82 for my testing, so I'm restricted to
> L2CAP as the lowest accessible layer). I looked through
> [include/]net/bluetooth/l2cap.[hc] and the Bluetooth spec, and I could
> easily set the default flush_to to 0x0001 (.625 milliseconds should be
> effectively 0, and with no packet to retransmit, it should timeout the
> retransmission). Am I on the right track, and would just changing all
> flush_to assignments to 0x0001 (including the default) work like I think
> it would? If I'm not on the right track, could someone point me to a


You do want to set the flush timeout for the l2cap socket, but you don't
want to use l2cap_options.flush_to. That parameter is not actually used yet
in the kernel (Marcel, please correct me if I'm wrong and you've changed
this lately).

See here for an example on how to set the flush timeout:

http://people.csail.mit.edu/albert/bluez-intro/x556.html#bzi-l2cap-unreliab=
le

Regards,
Albert

------=_Part_28353_5410372.1131136684283
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I would like to &quot;break&quot; the retransmission mechanism for L2CAP Pa=
ckets<br>
<div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(=
204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">(I am forced=
 to use Java and JSR-82 for my testing, so I'm restricted to<br>L2CAP as th=
e lowest accessible layer).&nbsp;&nbsp;I looked through
<br>[include/]net/bluetooth/l2cap.[hc] and the Bluetooth spec, and I could<=
br>easily set the default flush_to to 0x0001 (.625 milliseconds should be<b=
r>effectively 0, and with no packet to retransmit, it should timeout the
<br>retransmission).&nbsp;&nbsp;Am I on the right track, and would just cha=
nging all<br>flush_to assignments to 0x0001 (including the default) work li=
ke I think<br>it would?&nbsp;&nbsp;If I'm not on the right track, could som=
eone point me to a
</blockquote><div><br>
You do want to set the flush timeout for the l2cap socket, but you
don't want to use l2cap_options.flush_to.&nbsp; That parameter is not
actually used yet in the kernel (Marcel, please correct me if I'm wrong
and you've changed this lately).<br>
<br>
See here for an example on how to set the flush timeout:<br>
<br>
<a href=3D"http://people.csail.mit.edu/albert/bluez-intro/x556.html#bzi-l2c=
ap-unreliable">http://people.csail.mit.edu/albert/bluez-intro/x556.html#bzi=
-l2cap-unreliable</a><br>
<br>
Regards,<br>
Albert<br>
</div></div><br>


------=_Part_28353_5410372.1131136684283--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
