Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <57c68ddc0704160741y7399f051rd3aaf6fe885cd57c@mail.gmail.com>
Date: Mon, 16 Apr 2007 20:11:15 +0530
From: "siddhant tewari" <siddhant.tewari@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1176731130.30165.26.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
References: <57c68ddc0704160608p5daa06b8o73bad2bdb8a4fda@mail.gmail.com>
	<1176731130.30165.26.camel@aeonflux.holtmann.net>
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
Content-Type: multipart/mixed; boundary="===============2081907092=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============2081907092==
Content-Type: multipart/alternative;
	boundary="----=_Part_50182_25474733.1176734475677"

------=_Part_50182_25474733.1176734475677
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi Marcel,
                 I am using using kernel 2.4.26.
                 cant find anything with dmesg output.

                 When trying to run hcid at the prompt i am getting message

                  Can't init device hci1 : Connection time out.

                 What can be the possible reasons for this ???

regards
siddhant


On 4/16/07, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi,
>
> >     I am using bluez on arm single board computer and i am facing this
> > strange problem.
> >
> > When i am using only one bluetooth dongle , hciconfig correctly
> > reports the bluetooth address of the dongle but when i insert a second
> > dongle then the second dongles bt address is reported as
> > 00:00:00:00:00:00 .
> >
> > Both the dongles individually work fine.
> >
> > Can anyone tell me what can be the cause for such a problem ????
>
> never tried it on ARM machines. Check the output of dmesg. Maybe your
> USB stack has a problem on ARM. Do you run the latest 2.6 kernel?
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

------=_Part_50182_25474733.1176734475677
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi Marcel,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I am using using kernel 2.4.26. <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cant find anything with dmesg output.<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; When trying to run hcid at the prompt i am getting message  <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Can&#39;t init device hci1 : Connection time out.<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; What can be the possible reasons for this ???<br><br>regards<br>siddhant<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br><br><div><span class="gmail_quote">
On 4/16/07, <b class="gmail_sendername">Marcel Holtmann</b> &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi,<br><br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; I am using bluez on arm single board computer and i am facing this<br>&gt; strange problem.<br>&gt;<br>&gt; When i am using only one bluetooth dongle , hciconfig correctly<br>&gt; reports the bluetooth address of the dongle but when i insert a second
<br>&gt; dongle then the second dongles bt address is reported as<br>&gt; 00:00:00:00:00:00 .<br>&gt;<br>&gt; Both the dongles individually work fine.<br>&gt;<br>&gt; Can anyone tell me what can be the cause for such a problem ????
<br><br>never tried it on ARM machines. Check the output of dmesg. Maybe your<br>USB stack has a problem on ARM. Do you run the latest 2.6 kernel?<br><br>Regards<br><br>Marcel<br><br><br><br>-------------------------------------------------------------------------
<br>This SF.net email is sponsored by DB2 Express<br>Download DB2 Express C - the FREE version of DB2 express and take<br>control of your XML. No limits. Just data. Click to get it now.<br><a href="http://sourceforge.net/powerbar/db2/">
http://sourceforge.net/powerbar/db2/</a><br>_______________________________________________<br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">
https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></blockquote></div><br>

------=_Part_50182_25474733.1176734475677--


--===============2081907092==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============2081907092==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============2081907092==--
