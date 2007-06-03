Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <d89ddf300706031548m725fa8c3wabcb72a10e15cfb5@mail.gmail.com>
Date: Sun, 3 Jun 2007 16:48:49 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <297218.79751.qm@web62303.mail.re1.yahoo.com>
MIME-Version: 1.0
References: <d89ddf300706030814n3c66c621r80fb45ebee05b378@mail.gmail.com>
	<297218.79751.qm@web62303.mail.re1.yahoo.com>
Subject: Re: [Bluez-users] alsa module rebuild
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2042539600=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============2042539600==
Content-Type: multipart/alternative;
	boundary="----=_Part_2901_5887027.1180910929924"

------=_Part_2901_5887027.1180910929924
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Walt

try_to_freeze seems to do something real if config_pm is defined and
otherwise it is a trivial function. either way it should be there, at least
in 2.6.17 in sched.h.

things may have changed more recently.

Brad

On 6/3/07, walt shekrota <penguinacity@yahoo.com> wrote:
>
> Ahhhh I knew a step was missing but couldn't see it in any infos.
> Now it has load problems :(
> warning on make
>
>     INSTALL /home/wshek/btsco-0.5/kernel/snd-bt-sco.ko
>     DEPMOD  2.6.20-gentoo-r7
>     WARNING: /lib/modules/2.6.20-gentoo-r7/extra/snd-bt-sco.ko needs
> unknown symbol try_to_freeze
>
> probably a kernel dependency I have not enabled? Something new?

------=_Part_2901_5887027.1180910929924
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Walt<br><br>try_to_freeze seems to do something real if config_pm is defined and otherwise it is a trivial function. either way it should be there, at least in 2.6.17 in sched.h.<br><br>things may have changed more recently.
<br><br>Brad<br><br><div><span class="gmail_quote">On 6/3/07, <b class="gmail_sendername">walt shekrota</b> &lt;<a href="mailto:penguinacity@yahoo.com">penguinacity@yahoo.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Ahhhh I knew a step was missing but couldn&#39;t see it in any infos.<br> Now it has load problems :(<br> warning on make<br> <br> &nbsp;&nbsp;&nbsp; INSTALL /home/wshek/btsco-0.5/kernel/snd-bt-sco.ko<br> &nbsp;&nbsp;&nbsp; DEPMOD&nbsp; 2.6.20-gentoo-r7<br>
 &nbsp;&nbsp;&nbsp; WARNING: /lib/modules/2.6.20-gentoo-r7/extra/snd-bt-sco.ko needs unknown symbol try_to_freeze<br> <br> probably a kernel dependency I have not enabled? Something new?</blockquote></div><br>

------=_Part_2901_5887027.1180910929924--


--===============2042539600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============2042539600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============2042539600==--
