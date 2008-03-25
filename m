Return-Path: <cyrus@holtmann.org>
Message-ID: <8f5c4ad0803250600q4b36a962w27e57fc3210ebd09@mail.gmail.com>
Date: Tue, 25 Mar 2008 18:30:12 +0530
From: Paul <chemvell@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <d89ddf300803250516j6cf27fdbjf0740759b823435a@mail.gmail.com>
MIME-Version: 1.0
References: <8f5c4ad0803250501x51e5cac8m7c21a6e41460c644@mail.gmail.com>
	<d89ddf300803250516j6cf27fdbjf0740759b823435a@mail.gmail.com>
Subject: Re: [Bluez-users] ACL connection handle
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1817109170=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1817109170==
Content-Type: multipart/alternative;
	boundary="----=_Part_10285_33175080.1206450012097"

------=_Part_10285_33175080.1206450012097
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

     Brad,
   I am using the infineon.When I play through the uart, I will give -D
bluetooth option to aplay  and this  will create an acl as well as sco
connection and route audio through uart.But if I am  using the pcm interface
, I will  route  audio to the pcm interface  on the host connected to the bt
module and use aplay without the bluetooth option right?,So I have to
create  an acl connection and then use the hcitool cmd to  switch the SCO
interface before I do aplay .So is that necessary to give the command from
inside the audio service ?How would I establish the acl connection? Can I
use rfcomm connect ?

Thanks again for your time,
Regards,
Matt.

On Tue, Mar 25, 2008 at 5:46 PM, Brad Midgley <bmidgley@gmail.com> wrote:

> Paul/Matt
>
> >      I have a bluetooth module in which there is an option  to select
> the
> > interface (HCI or PCM) for the next SCO connection.This is done by
> sending
> > an HCI command .
>
> the infineon works this way. I believe the timing of this hci command
> (after establishing acl, before establishing sco) will require the
> code to be invoked from inside our audio service.
>
> --
> Brad
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

------=_Part_10285_33175080.1206450012097
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

&nbsp;&nbsp;&nbsp;&nbsp; Brad,<br>&nbsp;&nbsp; I am using the infineon.When I play through the uart, I will give -D bluetooth option to aplay&nbsp; and this&nbsp; will create an acl as well as sco connection and route audio through uart.But if I am&nbsp; using the pcm interface , I will&nbsp; route&nbsp; audio to the pcm interface&nbsp; on the host connected to the bt module and use aplay without the bluetooth option right?,So I have to create&nbsp; an acl connection and then use the hcitool cmd to&nbsp; switch the SCO interface before I do aplay .So is that necessary to give the command from inside the audio service ?How would I establish the acl connection? Can I use rfcomm connect ?<br>
<br>Thanks again for your time,<br>Regards,<br>Matt.<br><br><div class="gmail_quote">On Tue, Mar 25, 2008 at 5:46 PM, Brad Midgley &lt;<a href="mailto:bmidgley@gmail.com">bmidgley@gmail.com</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Paul/Matt<br>
<div class="Ih2E3d"><br>
&gt; &nbsp; &nbsp; &nbsp;I have a bluetooth module in which there is an option &nbsp;to select the<br>
&gt; interface (HCI or PCM) for the next SCO connection.This is done by sending<br>
&gt; an HCI command .<br>
<br>
</div>the infineon works this way. I believe the timing of this hci command<br>
(after establishing acl, before establishing sco) will require the<br>
code to be invoked from inside our audio service.<br>
<br>
--<br>
Brad<br>
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

------=_Part_10285_33175080.1206450012097--


--===============1817109170==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1817109170==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1817109170==--
