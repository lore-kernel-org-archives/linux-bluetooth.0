Return-Path: <cyrus@holtmann.org>
Message-ID: <2d5cd43e0803101020u702a60efkc712d122a9970a44@mail.gmail.com>
Date: Mon, 10 Mar 2008 22:50:53 +0530
From: "manuwela kanade" <manuwelak@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <A0E9FA39-0B62-4D12-B243-A8002AC48F37@holtmann.org>
MIME-Version: 1.0
References: <2cb4fa160803050333j22a9bc9et68f30c2664d34061@mail.gmail.com>
	<d89ddf300803050603k17a30359g173ab08f0756ff49@mail.gmail.com>
	<59861CFE-213C-4E19-B3B9-9FD3875434B9@holtmann.org>
	<2d5cd43e0803100324g683c6bdbl33f9025d9d673512@mail.gmail.com>
	<A0E9FA39-0B62-4D12-B243-A8002AC48F37@holtmann.org>
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
Content-Type: multipart/mixed; boundary="===============1296897633=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1296897633==
Content-Type: multipart/alternative;
	boundary="----=_Part_450_28707799.1205169653039"

------=_Part_450_28707799.1205169653039
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Sir,

Thank you so much for the reply. I will check the examples. Thank you.

Manuwela

On 3/10/08, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Manuwela,
>
>
> > Please can you tell me how to use the L2CAP_LM_MASTER. Should it be
> > defined while socket creation? And due to this switching of role, is
> > it possible to send data simultaneously?? Because, we have tried to
> > multithread and accept connections from multiple devices on the
> > server, but it does not work... only one connection is accepted by
> > server.
>
>
> the bluez-utils contains a lot of examples on how to use it. Check the
> files l2test.c and rctest.c for example.
>
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

------=_Part_450_28707799.1205169653039
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Sir,<br>
<br>
Thank you so much for the reply. I will check the examples. Thank you.<br>
<br>
Manuwela<br><br><div><span class="gmail_quote">On 3/10/08, <b class="gmail_sendername">Marcel Holtmann</b> &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Manuwela,<br> <br><br> &gt; Please can you tell me how to use the L2CAP_LM_MASTER. Should it be<br> &gt; defined while socket creation? And due to this switching of role, is<br> &gt; it possible to send data simultaneously?? Because, we have tried to<br>
 &gt; multithread and accept connections from multiple devices on the<br> &gt; server, but it does not work... only one connection is accepted by<br> &gt; server.<br> <br> <br>the bluez-utils contains a lot of examples on how to use it. Check the<br>
 files l2test.c and rctest.c for example.<br> <br><br> Regards<br> <br> Marcel<br> <br> <br> -------------------------------------------------------------------------<br> This SF.net email is sponsored by: Microsoft<br> Defy all challenges. Microsoft(R) Visual Studio 2008.<br>
 <a href="http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/">http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/</a><br> _______________________________________________<br> Bluez-users mailing list<br> <a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br>
 <a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br> </blockquote></div><br>

------=_Part_450_28707799.1205169653039--


--===============1296897633==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1296897633==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1296897633==--
