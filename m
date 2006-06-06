Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <549053140606060015h1f95955ao63714bd03df53998@mail.gmail.com>
Date: Tue, 6 Jun 2006 02:15:40 -0500
From: "Carl Karsten" <cfkarsten@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1149371447.1977.13.camel@localhost>
MIME-Version: 1.0
References: <549053140606021732w4263c5c2g93efa4cdf9a7614d@mail.gmail.com>
	<1149362263.1977.4.camel@localhost>
	<549053140606031339i43cee0a7h8622f83d76370504@mail.gmail.com>
	<1149371447.1977.13.camel@localhost>
Subject: Re: [Bluez-users] PM325 by LG cell phone
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1056082674=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1056082674==
Content-Type: multipart/alternative;
	boundary="----=_Part_6267_20725598.1149578140978"

------=_Part_6267_20725598.1149578140978
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 6/3/06, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Carl,
>
> >         > Service Name: Dialup Networking
> >         > Service RecHandle: 0x10003
> >         > Service Class ID List:
> >         >   "Dialup Networking" (0x1103)
> >         > Protocol Descriptor List:
> >         >   "L2CAP" (0x0100)
> >         >   "RFCOMM" (0x0003)
> >         >     Channel: 4
> >         > Profile Descriptor List:
> >         >   "Dialup Networking" (0x1103)
> >         >     Version: 0x0100
> >         >
> >         > I am not sure what to do next.  looks like audio and dun are
> >         the only
> >         > profiles the phone supports, so DUN seems like a good place
> >         to start.
> >
> >         with DUN you can use your mobile phone to dialup to the
> >         Internet. It
> >         makes you phone look like a modem. The audio profiles allow
> >         you to
> >         connect a headset to your phone.
> >
> >
> > I am assuming I can connect minicom to it and issue AT commands.  I
> > couln't find any instructions on how.
>
> call "rfcomm connect 0 <bdaddr> 4" and you will get a /dev/rfcomm0
> terminal device you can use with minicom or whatever program supporting
> Linux TTY devices.
>
>
carl@asus17:~$ sudo rfcomm connect 0 08:00:37:03:EF:36 4
Can't connect RFCOMM socket: Connection refused

I am not sure I have paired.  If I did, does rebooting phone or linux end
that 'session' ?

------=_Part_6267_20725598.1149578140978
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">On 6/3/06, <b class="gmail_sendername">Marcel Holtmann</b> &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Carl,<br><br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Service Name: Dialup Networking<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Service RecHandle: 0x10003<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Service Class ID List:<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp; &quot;Dialup Networking&quot; (0x1103)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Protocol Descriptor List:<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp; &quot;L2CAP&quot; (0x0100)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp; &quot;RFCOMM&quot; (0x0003)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; Channel: 4<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Profile Descriptor List:
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp; &quot;Dialup Networking&quot; (0x1103)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; Version: 0x0100<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; I am not sure what to do next.&nbsp;&nbsp;looks like audio and dun are<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the only
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; profiles the phone supports, so DUN seems like a good place<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to start.<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; with DUN you can use your mobile phone to dialup to the<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Internet. It<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; makes you phone look like a modem. The audio profiles allow
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; you to<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; connect a headset to your phone.<br>&gt;<br>&gt;<br>&gt; I am assuming I can connect minicom to it and issue AT commands.&nbsp;&nbsp;I<br>&gt; couln't find any instructions on how.<br><br>call &quot;rfcomm connect 0 &lt;bdaddr&gt; 4&quot; and you will get a /dev/rfcomm0
<br>terminal device you can use with minicom or whatever program supporting<br>Linux TTY devices.<br><br></blockquote></div><br>carl@asus17:~$ sudo rfcomm connect 0 08:00:37:03:EF:36 4<br>Can't connect RFCOMM socket: Connection refused
<br><br>I am not sure I have paired.&nbsp; If I did, does rebooting phone or linux end that 'session' ?<br>

------=_Part_6267_20725598.1149578140978--


--===============1056082674==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1056082674==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1056082674==--
