Return-Path: <cyrus@holtmann.org>
Message-ID: <e378cfb20801152226y782d2a01x7ac5f040684edea0@mail.gmail.com>
Date: Wed, 16 Jan 2008 11:56:05 +0530
From: "Nel D" <newatlinux@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <8f5c4ad0801152201j5a2564e2u34afcb9099afe0f9@mail.gmail.com>
MIME-Version: 1.0
References: <8f5c4ad0801152201j5a2564e2u34afcb9099afe0f9@mail.gmail.com>
Subject: Re: [Bluez-users] hciconfig not able to get the device address
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1107222328=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1107222328==
Content-Type: multipart/alternative;
	boundary="----=_Part_19126_9767796.1200464765198"

------=_Part_19126_9767796.1200464765198
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Jan 16, 2008 11:31 AM, Thark frency <chemvell@gmail.com> wrote:

> Hi all ,
>
>   I am using a USB-dongle with my linux box.I have installed
> bluez-utils-3.24 and bluez-libs-3.24 .
>
>             When I do a hciconfig the output looks like this
> # hciconfig
> hci0:   Type: USB
>         BD Address: 00:00:00:00:00:00 ACL MTU: 377:10        SCO MTU: 16:0
>         UP RUNNING PSCAN ISCAN
>         RX bytes:1500 acl:9 sco:0 events:81 errors:0
>         TX bytes:527 acl:8 sco:0 commands:26 errors:0
>


Try "hciconfig hci0 up" as root and see if this helps



>
> It is able to scan for other devices...and ping them.. Can somebody
> please  tell me why hciconfig is not able to get the device address?
>
> Thanks in advance...
> cheers,
> Thark.
>

regards,
nel

------=_Part_19126_9767796.1200464765198
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br><div class="gmail_quote">On Jan 16, 2008 11:31 AM, Thark frency &lt;<a href="mailto:chemvell@gmail.com">chemvell@gmail.com</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi all ,<br><br>&nbsp; I am using a USB-dongle with my linux box.I have installed bluez-utils-3.24 and bluez-libs-3.24 .<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; When I do a hciconfig the output looks like this <br># hciconfig<br>hci0:&nbsp;&nbsp; Type: USB<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:00:00:00:00:00 ACL MTU: 377:10&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SCO MTU: 16:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:1500 acl:9 sco:0 events:81 errors:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:527 acl:8 sco:0 commands:26 errors:0
<br></blockquote><div><br><br>Try &quot;hciconfig hci0 up&quot; as root and see if this helps<br><br>&nbsp;</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>It is able to scan for other devices...and ping them.. Can somebody please&nbsp; tell me why hciconfig is not able to get the device address?<br><br>Thanks in advance...<br>cheers,<br><font color="#888888">Thark.<br></font>
</blockquote></div><br>regards,<br>nel<br><br>

------=_Part_19126_9767796.1200464765198--


--===============1107222328==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1107222328==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1107222328==--
