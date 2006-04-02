Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <ef9938ec0604021017q786d33e5r32692f7fb33fad91@mail.gmail.com>
From: "Albert Huang" <ashuang@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Anonymous service setup
In-Reply-To: <20060401131949.fdb6d992.ml133@netpole.com.br>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1550_21451456.1143998275113"
References: <20060401131949.fdb6d992.ml133@netpole.com.br>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 2 Apr 2006 13:17:55 -0400

------=_Part_1550_21451456.1143998275113
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Many phones do not require authentication for OBEX Push.  You might try to
use that instead of OBEX File Transfer to avoid the PIN issue.  take a look
at ussp-push.

-albert

On 4/1/06, Christoph Simon <ml133@netpole.com.br> wrote:
>
> Hi,
>
> I was asked to set up a linux (debian) box, which has an usb bluetooth
> dongle, and which would allow anyone passing by and having a bluetooth
> enabled device, to fetch some file from the server.
>
> Unfortunately, I'm really stuck with all this, too many TLAs. I
> managed to run hciconfig listing the dongle, to scan and inquire a
> cellphone and to use l2ping on the MAC address. But there doesn't seem
> to be a way to make a basic filetransfer.
>
> When trying with obexftp, the celphone will asked for a PIN, when I
> enter that which is written in /etc/bluetooth/pin, but then it just
> hangs. In daemon.log, I can see the messages from hcid
> "link_key_request" and "pin_code_request" but nothing else. After some
> time, both obexftp desists, and the Motorola celphone would reboot. I
> have been looking for some sort of debug mode of hcid, but couldn't
> find any flag. I also changed the pin_helper line in the config file
> to be a shellscript which just outputs "PIN:1234", but still doesn't
> work. (the script is executable and works on the shell).
>
> Thus, my first question is, what do I need to do to make this work. I
> should work, right? And the second question is, what kind of service I
> would have to setup, such that anybody can get some files prepared on
> that server, with the minimum hassle of typing pincodes.
>
> Thanks,
>
> --
> Chris
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by xPML, a groundbreaking scripting
> language
> that extends applications into web and mobile media. Attend the live
> webcast
> and join the prime developer group breaking into this new coding
> territory!
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D110944&bid=3D241720&dat=
=3D121642
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_1550_21451456.1143998275113
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Many phones do not require authentication for OBEX Push.&nbsp; You
might try to use that instead of OBEX File Transfer to avoid the PIN
issue.&nbsp; take a look at ussp-push.<br>
<br>
-albert<br><br><div><span class=3D"gmail_quote">On 4/1/06, <b class=3D"gmai=
l_sendername">Christoph Simon</b> &lt;<a href=3D"mailto:ml133@netpole.com.b=
r">ml133@netpole.com.br</a>&gt; wrote:</span><blockquote class=3D"gmail_quo=
te" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt=
 0.8ex; padding-left: 1ex;">
Hi,<br><br>I was asked to set up a linux (debian) box, which has an usb blu=
etooth<br>dongle, and which would allow anyone passing by and having a blue=
tooth<br>enabled device, to fetch some file from the server.<br><br>Unfortu=
nately, I'm really stuck with all this, too many TLAs. I
<br>managed to run hciconfig listing the dongle, to scan and inquire a<br>c=
ellphone and to use l2ping on the MAC address. But there doesn't seem<br>to=
 be a way to make a basic filetransfer.<br><br>When trying with obexftp, th=
e celphone will asked for a PIN, when I
<br>enter that which is written in /etc/bluetooth/pin, but then it just<br>=
hangs. In daemon.log, I can see the messages from hcid<br>&quot;link_key_re=
quest&quot; and &quot;pin_code_request&quot; but nothing else. After some
<br>time, both obexftp desists, and the Motorola celphone would reboot. I<b=
r>have been looking for some sort of debug mode of hcid, but couldn't<br>fi=
nd any flag. I also changed the pin_helper line in the config file<br>to be=
 a shellscript which just outputs &quot;PIN:1234&quot;, but still doesn't
<br>work. (the script is executable and works on the shell).<br><br>Thus, m=
y first question is, what do I need to do to make this work. I<br>should wo=
rk, right? And the second question is, what kind of service I<br>would have=
 to setup, such that anybody can get some files prepared on
<br>that server, with the minimum hassle of typing pincodes.<br><br>Thanks,=
<br><br>--<br>Chris<br><br><br>--------------------------------------------=
-----------<br>This SF.Net email is sponsored by xPML, a groundbreaking scr=
ipting language
<br>that extends applications into web and mobile media. Attend the live we=
bcast<br>and join the prime developer group breaking into this new coding t=
erritory!<br><a href=3D"http://sel.as-us.falkag.net/sel?cmd=3Dlnk&amp;kid=
=3D110944&amp;bid=3D241720&amp;dat=3D121642">
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&amp;kid=3D110944&amp;bid=3D241720=
&amp;dat=3D121642</a><br>_______________________________________________<br=
>Bluez-users mailing list<br><a href=3D"mailto:Bluez-users@lists.sourceforg=
e.net">
Bluez-users@lists.sourceforge.net</a><br><a href=3D"https://lists.sourcefor=
ge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/list=
info/bluez-users</a><br></blockquote></div><br>

------=_Part_1550_21451456.1143998275113--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
