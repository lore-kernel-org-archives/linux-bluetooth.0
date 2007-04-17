Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <57c68ddc0704162156p342351e0m402325c729c19662@mail.gmail.com>
Date: Tue, 17 Apr 2007 10:26:27 +0530
From: "siddhant tewari" <siddhant.tewari@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1176744531.30165.40.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
References: <57c68ddc0704160608p5daa06b8o73bad2bdb8a4fda@mail.gmail.com>
	<1176731130.30165.26.camel@aeonflux.holtmann.net>
	<57c68ddc0704160741y7399f051rd3aaf6fe885cd57c@mail.gmail.com>
	<1176737786.30165.29.camel@aeonflux.holtmann.net>
	<57c68ddc0704160904u559bfc86n2933b86640a434a0@mail.gmail.com>
	<1176744531.30165.40.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-users] problem using two bluetooth dongles together
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1660847401=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1660847401==
Content-Type: multipart/alternative;
	boundary="----=_Part_65016_28218511.1176785787362"

------=_Part_65016_28218511.1176785787362
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi Marcel,
               Thanks for the advice , will surely port to 2.6 kernel.
regards
siddhant

On 4/16/07, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Siddhant,
>
> >     I will try to upgrade to 2.6 kernel but since this is arm Single
> > Board Computer , i am not sure about the effort and time  that would
> > be required to do so.
> >
> > I have another observation to share with you .
> >
> > When using two dongle , if i put hci0 down by hciconfig hci0 down
> > and then put hci1 up by hciconfig  hci1 up
> > then hciconfig returns correct address for the second adapter as well.
> >
> > Also if i try to put hci1 up  without putting hci0 down then same
> > thing
> >  ----- "cannot contact hci1 connection timed out" message appears.
> >
> > Please reply if you can give me some hints about whats happening after
> > going through the above observation.
>
> I am pretty sure that is the USB subsystem. Since when you down the
> adapter all URBs will be canceled. So you can try to change the
> constants for the number of URBs in hci_usb.h and recompile your kernel.
> You can also try to disable ISOC transfers (SCO support for the driver)
> and see if that takes the bandwidth pressure from the USB bus.
>
> However, the 2.6 USB subsystem is really the way to go. No effort on
> porting to 2.6 is wasted.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_65016_28218511.1176785787362
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi Marcel,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Thanks for the advice , will surely port to 2.6 kernel.<br>regards<br>siddhant<br><br><div><span class="gmail_quote">On 4/16/07, <b class="gmail_sendername">Marcel Holtmann</b> &lt;<a href="mailto:marcel@holtmann.org">
marcel@holtmann.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi Siddhant,<br><br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; I will try to upgrade to 
2.6 kernel but since this is arm Single<br>&gt; Board Computer , i am not sure about the effort and time&nbsp;&nbsp;that would<br>&gt; be required to do so.<br>&gt;<br>&gt; I have another observation to share with you .<br>&gt;<br>
&gt; When using two dongle , if i put hci0 down by hciconfig hci0 down<br>&gt; and then put hci1 up by hciconfig&nbsp;&nbsp;hci1 up<br>&gt; then hciconfig returns correct address for the second adapter as well.<br>&gt;<br>&gt; Also if i try to put hci1 up&nbsp;&nbsp;without putting hci0 down then same
<br>&gt; thing<br>&gt;&nbsp;&nbsp;----- &quot;cannot contact hci1 connection timed out&quot; message appears.<br>&gt;<br>&gt; Please reply if you can give me some hints about whats happening after<br>&gt; going through the above observation.
<br><br>I am pretty sure that is the USB subsystem. Since when you down the<br>adapter all URBs will be canceled. So you can try to change the<br>constants for the number of URBs in hci_usb.h and recompile your kernel.<br>
You can also try to disable ISOC transfers (SCO support for the driver)<br>and see if that takes the bandwidth pressure from the USB bus.<br><br>However, the 2.6 USB subsystem is really the way to go. No effort on<br>porting to 
2.6 is wasted.<br><br>Regards<br><br>Marcel<br><br><br><br>-------------------------------------------------------------------------<br>This SF.net email is sponsored by DB2 Express<br>Download DB2 Express C - the FREE version of DB2 express and take
<br>control of your XML. No limits. Just data. Click to get it now.<br><a href="http://sourceforge.net/powerbar/db2/">http://sourceforge.net/powerbar/db2/</a><br>_______________________________________________<br>Bluez-users mailing list
<br><a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users</a>
<br></blockquote></div><br>

------=_Part_65016_28218511.1176785787362--


--===============1660847401==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1660847401==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1660847401==--
