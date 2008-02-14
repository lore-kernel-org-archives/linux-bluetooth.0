Return-Path: <cyrus@holtmann.org>
Message-ID: <d5d240eb0802132154q400ddcf3g43ebf5b1fe0c85e7@mail.gmail.com>
Date: Thu, 14 Feb 2008 11:24:58 +0530
From: "rohit puri" <rohitpuri.rohit@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1202902617.7664.372.camel@violet>
MIME-Version: 1.0
References: <d5d240eb0802130321y7e2ad192w1d94f2aff75ebd70@mail.gmail.com>
	<1202902617.7664.372.camel@violet>
Subject: Re: [Bluez-users] Porblem in passkeyagent.c
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0932207025=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0932207025==
Content-Type: multipart/alternative;
	boundary="----=_Part_71_32295580.1202968498149"

------=_Part_71_32295580.1202968498149
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,

Thanks for reply.
I dont want to use  any graphical user environment .what I want is  to give
four number of  passkeys  from my code in  parallel.  want to pair one of
these four from remote device.

for example

passkey-agent   --default   99         77        88      66

now I want   the user   to pair  on  'one of   these'  four  passkeys from
moblie phone
thats why I need to find out where passkey matches

Regards
Rohit
On Wed, Feb 13, 2008 at 5:06 PM, Marcel Holtmann <marcel@holtmann.org>
wrote:

> Hi Rohit,
>
> > Can anybody please tell me in passkey-agent.c that comes with
> > bluez-utils3.24.where does passkey match in passkey-agent.c
>
> why don't you simply use bluez-gnome or kdebluetooth. They both come
> with a passkey agent implementation. No need to fiddle around it by
> yourself. The passkey-agent.c code is also only an example code that is
> included for demonstration.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2008.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_71_32295580.1202968498149
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,<br><br>Thanks for reply.<br>I dont want to use&nbsp; any graphical user environment .what I want is&nbsp; to give four number of&nbsp; passkeys&nbsp; from my code in&nbsp; parallel.&nbsp; want to pair one of these four from remote device.<br>
<br>for example <br><br>passkey-agent&nbsp;&nbsp; --default&nbsp;&nbsp;  99&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 77&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 88&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 66<br><br>now I want&nbsp;&nbsp; the user&nbsp;&nbsp; to pair&nbsp; on&nbsp; &#39;one of&nbsp;&nbsp; these&#39;&nbsp; four&nbsp; passkeys from moblie phone <br>thats why I need to find out where passkey matches<br>
<br>Regards<br>Rohit<br><div class="gmail_quote">On Wed, Feb 13, 2008 at 5:06 PM, Marcel Holtmann &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Rohit,<br>
<div class="Ih2E3d"><br>
&gt; Can anybody please tell me in passkey-agent.c that comes with<br>
&gt; bluez-utils3.24.where does passkey match in passkey-agent.c<br>
<br>
</div>why don&#39;t you simply use bluez-gnome or kdebluetooth. They both come<br>
with a passkey agent implementation. No need to fiddle around it by<br>
yourself. The passkey-agent.c code is also only an example code that is<br>
included for demonstration.<br>
<br>
Regards<br>
<br>
Marcel<br>
<br>
<br>
<br>
-------------------------------------------------------------------------<br>
This SF.net email is sponsored by: Microsoft<br>
Defy all challenges. Microsoft(R) Visual Studio 2008.<br>
<a href="http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/" target="_blank">http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/</a><br>
_______________________________________________<br>
Bluez-users mailing list<br>
<a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br>
<a href="https://lists.sourceforge.net/lists/listinfo/bluez-users" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br>
</blockquote></div><br>

------=_Part_71_32295580.1202968498149--


--===============0932207025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0932207025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0932207025==--
