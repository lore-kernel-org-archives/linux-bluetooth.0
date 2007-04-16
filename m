Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <57c68ddc0704160904u559bfc86n2933b86640a434a0@mail.gmail.com>
Date: Mon, 16 Apr 2007 21:34:15 +0530
From: "siddhant tewari" <siddhant.tewari@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1176737786.30165.29.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
References: <57c68ddc0704160608p5daa06b8o73bad2bdb8a4fda@mail.gmail.com>
	<1176731130.30165.26.camel@aeonflux.holtmann.net>
	<57c68ddc0704160741y7399f051rd3aaf6fe885cd57c@mail.gmail.com>
	<1176737786.30165.29.camel@aeonflux.holtmann.net>
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
Content-Type: multipart/mixed; boundary="===============2050985233=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============2050985233==
Content-Type: multipart/alternative;
	boundary="----=_Part_52362_1167905.1176739455511"

------=_Part_52362_1167905.1176739455511
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi Marcel,

    I will try to upgrade to 2.6 kernel but since this is arm Single Board
Computer , i am not sure about the effort and time  that would be required
to do so.

I have another observation to share with you .

When using two dongle , if i put hci0 down by hciconfig hci0 down
and then put hci1 up by hciconfig  hci1 up
then hciconfig returns correct address for the second adapter as well.

Also if i try to put hci1 up  without putting hci0 down then same thing
 ----- "cannot contact hci1 connection timed out" message appears.

Please reply if you can give me some hints about whats happening after going
through the above observation.

regards
siddhant



On 4/16/07, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Siddhant,
>
> >                  I am using using kernel 2.4.26.
> >                  cant find anything with dmesg output.
> >
> >                  When trying to run hcid at the prompt i am getting
> > message
> >
> >                   Can't init device hci1 : Connection time out.
> >
> >                  What can be the possible reasons for this ???
>
> the USB stack in 2.4.26 is very old. So is the Bluetooth stack. You
> should really start using a 2.6 kernel.
>
> My guess is that you have problems with the USB support in this ancient
> kernel.
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

------=_Part_52362_1167905.1176739455511
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi Marcel,<br><br>&nbsp;&nbsp;&nbsp; I will try to upgrade to 2.6 kernel but since this is arm Single Board Computer , i am not sure about the effort and time&nbsp; that would be required to do so. <br><br>I have another observation to share with you . 
<br><br>When using two dongle , if i put hci0 down by hciconfig hci0 down<br>and then put hci1 up by hciconfig&nbsp; hci1 up <br>then hciconfig returns correct address for the second adapter as well.<br><br>Also if i try to put hci1 up&nbsp; without putting hci0 down then same thing
<br>&nbsp;----- &quot;cannot contact hci1 connection timed out&quot; message appears.<br><br>Please reply if you can give me some hints about whats happening after going through the above observation.<br><br>regards<br>siddhant
<br><br><br><br><div><span class="gmail_quote">On 4/16/07, <b class="gmail_sendername">Marcel Holtmann</b> &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Siddhant,<br><br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I am using using kernel 2.4.26.<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cant find anything with dmesg output.<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;When trying to run hcid at the prompt i am getting<br>
&gt; message<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Can&#39;t init device hci1 : Connection time out.<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;What can be the possible reasons for this ???<br><br>the USB stack in 2.4.26 is very old. So is the Bluetooth stack. You
<br>should really start using a 2.6 kernel.<br><br>My guess is that you have problems with the USB support in this ancient<br>kernel.<br><br>Regards<br><br>Marcel<br><br><br><br>-------------------------------------------------------------------------
<br>This SF.net email is sponsored by DB2 Express<br>Download DB2 Express C - the FREE version of DB2 express and take<br>control of your XML. No limits. Just data. Click to get it now.<br><a href="http://sourceforge.net/powerbar/db2/">
http://sourceforge.net/powerbar/db2/</a><br>_______________________________________________<br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">
https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></blockquote></div><br>

------=_Part_52362_1167905.1176739455511--


--===============2050985233==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============2050985233==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============2050985233==--
