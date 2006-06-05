Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <5d12691e0606051652h660e446dm5e82bfbe74c121f5@mail.gmail.com>
Date: Mon, 5 Jun 2006 16:52:37 -0700
From: "Aaron Miller" <armantic101@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1149362073.1977.0.camel@localhost>
MIME-Version: 1.0
References: <5d12691e0606021931hd95b058u38f464d30af8fd56@mail.gmail.com>
	<1149334394.19311.17.camel@localhost>
	<5d12691e0606031048o148ad92bre33d6efe2b280560@mail.gmail.com>
	<1149362073.1977.0.camel@localhost>
Subject: Re: [Bluez-users] bluez udev rules for Slackware 10.2
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1428009980=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1428009980==
Content-Type: multipart/alternative;
	boundary="----=_Part_38932_19458109.1149551557212"

------=_Part_38932_19458109.1149551557212
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<smacks myself on head>
Reading the rfcomm man page was actually what sent me on this long quest to
create an rfcomm device. I misunderstood 'rfcomm bind <dev>' to mean that I
had to supply it with the device that already existed. After your comments,
and rereading the man page, I see that <dev> is the device I want to create,
not the one that is already there. All is good now.

Thanks for your help!
...aaron

On 6/3/06, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Aaron,
>
> >  I'm sorry I wasn't more specific, I didn't realize that there were
> > other devices then the rfcomm tty device node. This is actually the on
> > I am after sense it is needed for my device to work with p3nfs.
> >
> > I have RFCOMM protocol support enabled in the kernel as a modules, and
> > RFCOMM TTY support hard coded. I had to 'modprobe rfcomm' but the
> > bluetooth module loaded automatically, both of which are listed in my
> > 'lsmod'. How do I get udev to create the rfcomm device node? I
> > searched for files containing "rfcomm" in the bluez build directory
> > but didn't see anything relating to udev rules. Am I supposed to build
> > this node myself or should udev be creating it automatically?
>
> you will see these device nodes if you bind or connect a RFCOMM TTY to a
> remote device. See the rfcomm command for more details.
>
> Regards
>
> Marcel
>
>
>
>
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_38932_19458109.1149551557212
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>&lt;smacks myself on head&gt;</div>
<div>Reading the rfcomm man page was actually what sent me on this long quest to create an rfcomm device. I misunderstood 'rfcomm bind&nbsp;&lt;dev&gt;' to mean that I had to supply it with the device that already existed. After your comments, and rereading the man page, I see that &lt;dev&gt; is the device I want to create, not the one that is already there. All is good now.
</div>
<div>&nbsp;</div>
<div>Thanks for your help!</div>
<div>...aaron<br>&nbsp;</div>
<div><span class="gmail_quote">On 6/3/06, <b class="gmail_sendername">Marcel Holtmann</b> &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hi Aaron,<br><br>&gt;&nbsp;&nbsp;I'm sorry I wasn't more specific, I didn't realize that there were<br>&gt; other devices then the rfcomm tty device node. This is actually the on
<br>&gt; I am after sense it is needed for my device to work with p3nfs.<br>&gt;<br>&gt; I have RFCOMM protocol support enabled in the kernel as a modules, and<br>&gt; RFCOMM TTY support hard coded. I had to 'modprobe rfcomm' but the
<br>&gt; bluetooth module loaded automatically, both of which are listed in my<br>&gt; 'lsmod'. How do I get udev to create the rfcomm device node? I<br>&gt; searched for files containing &quot;rfcomm&quot; in the bluez build directory
<br>&gt; but didn't see anything relating to udev rules. Am I supposed to build<br>&gt; this node myself or should udev be creating it automatically?<br><br>you will see these device nodes if you bind or connect a RFCOMM TTY to a
<br>remote device. See the rfcomm command for more details.<br><br>Regards<br><br>Marcel<br><br><br><br><br>_______________________________________________<br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net">
Bluez-users@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></blockquote></div><br>

------=_Part_38932_19458109.1149551557212--


--===============1428009980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1428009980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1428009980==--
