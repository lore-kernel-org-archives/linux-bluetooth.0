Return-Path: <cyrus@holtmann.org>
Message-ID: <2d5cd43e0803100324g683c6bdbl33f9025d9d673512@mail.gmail.com>
Date: Mon, 10 Mar 2008 15:54:46 +0530
From: "manuwela kanade" <manuwelak@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <59861CFE-213C-4E19-B3B9-9FD3875434B9@holtmann.org>
MIME-Version: 1.0
References: <2cb4fa160803050333j22a9bc9et68f30c2664d34061@mail.gmail.com>
	<d89ddf300803050603k17a30359g173ab08f0756ff49@mail.gmail.com>
	<59861CFE-213C-4E19-B3B9-9FD3875434B9@holtmann.org>
Subject: Re: [Bluez-users] Question about bluetooth simultaneous connections
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0362130471=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0362130471==
Content-Type: multipart/alternative;
	boundary="----=_Part_38221_19068936.1205144686613"

------=_Part_38221_19068936.1205144686613
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Sir,

Please can you tell me how to use the L2CAP_LM_MASTER. Should it be defined
while socket creation? And due to this switching of role, is it possible to
send data simultaneously?? Because, we have tried to multithread and accept
connections from multiple devices on the server, but it does not work...
only one connection is accepted by server.

Thank you,
Manuwela

On Sat, Mar 8, 2008 at 12:11 AM, Marcel Holtmann <marcel@holtmann.org>
wrote:

> Hi Brad,
>
> > Mohomed, you'll get closer to 7 if you try to keep your device master
> > on its connections. Something like calling a fn after estabishing
> > connections:
>
> the RFCOMM and L2CAP sockets provide a {L2CAP|RFCOMM}_LM_MASTER to do
> this task on the server socket directly.
>
> Regards
>
> Marcel
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

------=_Part_38221_19068936.1205144686613
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Sir,<br><br>Please can you tell me how to use the L2CAP_LM_MASTER. Should it be defined while socket creation? And due to this switching of role, is it possible to send data simultaneously?? Because, we have tried to multithread and accept connections from multiple devices on the server, but it does not work... only one connection is accepted by server.<br>
<br>Thank you,<br>Manuwela<br><br><div class="gmail_quote">On Sat, Mar 8, 2008 at 12:11 AM, Marcel Holtmann &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Brad,<br>
<div class="Ih2E3d"><br>
&gt; Mohomed, you&#39;ll get closer to 7 if you try to keep your device master<br>
&gt; on its connections. Something like calling a fn after estabishing<br>
&gt; connections:<br>
<br>
</div>the RFCOMM and L2CAP sockets provide a {L2CAP|RFCOMM}_LM_MASTER to do<br>
this task on the server socket directly.<br>
<br>
Regards<br>
<font color="#888888"><br>
Marcel<br>
</font><div><div></div><div class="Wj3C7c"><br>
<br>
-------------------------------------------------------------------------<br>
This SF.net email is sponsored by: Microsoft<br>
Defy all challenges. Microsoft(R) Visual Studio 2008.<br>
<a href="http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/" target="_blank">http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/</a><br>
_______________________________________________<br>
Bluez-users mailing list<br>
<a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br>
<a href="https://lists.sourceforge.net/lists/listinfo/bluez-users" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br>
</div></div></blockquote></div><br>

------=_Part_38221_19068936.1205144686613--


--===============0362130471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0362130471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0362130471==--
