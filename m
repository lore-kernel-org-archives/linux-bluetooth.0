Return-Path: <cyrus@holtmann.org>
Message-ID: <8f5c4ad0801152316v9ede777g5304881e49613ae0@mail.gmail.com>
Date: Wed, 16 Jan 2008 12:46:33 +0530
From: "Thark frency" <chemvell@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <e378cfb20801152226y782d2a01x7ac5f040684edea0@mail.gmail.com>
MIME-Version: 1.0
References: <8f5c4ad0801152201j5a2564e2u34afcb9099afe0f9@mail.gmail.com>
	<e378cfb20801152226y782d2a01x7ac5f040684edea0@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============0226666409=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0226666409==
Content-Type: multipart/alternative;
	boundary="----=_Part_16672_19664208.1200467793774"

------=_Part_16672_19664208.1200467793774
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

  Hi ,

   Thanks for your quick reply.I started the hcid and did hciconfig hci0
up...but still the output of hciconfig is the same.The outputs of "hciconfig
hci0 version" and "hciconfig hci0 class" are as follows..

#hciconfig hci0 version
hci0:   Type: USB
        BD Address: 00:00:00:00:00:00 ACL MTU: 377:10 SCO MTU: 16:0
        HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 0x309
        Manufacturer: Broadcom Corporation (15)

#hciconfig hci0 class
hci0:   Type: USB
        BD Address: 00:00:00:00:00:00 ACL MTU: 377:10 SCO MTU: 16:0
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized

hope these will give you a better picture of my problem...
Thanks again..
Cheers,
Thark.



On Jan 16, 2008 11:56 AM, Nel D <newatlinux@gmail.com> wrote:

> Hi,
>
> On Jan 16, 2008 11:31 AM, Thark frency <chemvell@gmail.com> wrote:
>
> > Hi all ,
> >
> >   I am using a USB-dongle with my linux box.I have installed
> > bluez-utils-3.24 and bluez-libs-3.24 .
> >
> >             When I do a hciconfig the output looks like this
> > # hciconfig
> > hci0:   Type: USB
> >         BD Address: 00:00:00:00:00:00 ACL MTU: 377:10        SCO MTU:
> > 16:0
> >         UP RUNNING PSCAN ISCAN
> >         RX bytes:1500 acl:9 sco:0 events:81 errors:0
> >         TX bytes:527 acl:8 sco:0 commands:26 errors:0
> >
>
>
> Try "hciconfig hci0 up" as root and see if this helps
>
>
>
> >
> > It is able to scan for other devices...and ping them.. Can somebody
> > please  tell me why hciconfig is not able to get the device address?
> >
> > Thanks in advance...
> > cheers,
> > Thark.
> >
>
> regards,
> nel
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
>

------=_Part_16672_19664208.1200467793774
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

&nbsp; Hi ,<br><br>&nbsp;&nbsp; Thanks for your quick reply.I started the hcid and did hciconfig hci0 up...but still the output of hciconfig is the same.The outputs of &quot;hciconfig hci0 version&quot; and &quot;hciconfig hci0 class&quot; are as follows..
<br><br>#hciconfig hci0 version<br>hci0:&nbsp;&nbsp; Type: USB<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:00:00:00:00:00 ACL MTU: 377:10 SCO MTU: 16:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 0x309<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Broadcom Corporation (15)
<br><br>#hciconfig hci0 class<br>hci0:&nbsp;&nbsp; Type: USB<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:00:00:00:00:00 ACL MTU: 377:10 SCO MTU: 16:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Class: 0x000100<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Service Classes: Unspecified<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Class: Computer, Uncategorized
<br><br>hope these will give you a better picture of my problem...<br>Thanks again..<br>Cheers,<br>Thark.<br><br><br><br><div class="gmail_quote">On Jan 16, 2008 11:56 AM, Nel D &lt;<a href="mailto:newatlinux@gmail.com">newatlinux@gmail.com
</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi,<br><br><div class="gmail_quote"><div class="Ih2E3d">On Jan 16, 2008 11:31 AM, Thark frency &lt;
<a href="mailto:chemvell@gmail.com" target="_blank">chemvell@gmail.com</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi all ,<br><br>&nbsp; I am using a USB-dongle with my linux box.I have installed bluez-utils-3.24 and bluez-libs-3.24 .<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; When I do a hciconfig the output looks like this <br># hciconfig<br>hci0:&nbsp;&nbsp; Type: USB
<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:00:00:00:00:00 ACL MTU: 377:10&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SCO MTU: 16:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:1500 acl:9 sco:0 events:81 errors:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:527 acl:8 sco:0 commands:26 errors:0
<br></blockquote></div><div><br><br>Try &quot;hciconfig hci0 up&quot; as root and see if this helps<br><br>&nbsp;</div><div class="Ih2E3d"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

<br>It is able to scan for other devices...and ping them.. Can somebody please&nbsp; tell me why hciconfig is not able to get the device address?<br><br>Thanks in advance...<br>cheers,<br><font color="#888888">Thark.<br></font>

</blockquote></div></div><br>regards,<br><font color="#888888">nel<br><br>
</font><br>-------------------------------------------------------------------------<br>This SF.net email is sponsored by: Microsoft<br>Defy all challenges. Microsoft(R) Visual Studio 2008.<br><a href="http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/" target="_blank">
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/</a><br>_______________________________________________<br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net
</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br><br></blockquote></div><br>

------=_Part_16672_19664208.1200467793774--


--===============0226666409==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0226666409==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0226666409==--
