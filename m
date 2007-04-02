Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <b621074b0704020451o3bde514ay12d20cece9c71846@mail.gmail.com>
Date: Mon, 2 Apr 2007 17:21:38 +0530
From: "Tushar Paturde" <tusharpaturde@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1175511796.5815.329.camel@violet>
MIME-Version: 1.0
References: <b621074b0704020400r2e1500d5u4972031e010a05e5@mail.gmail.com>
	<1175511796.5815.329.camel@violet>
Subject: Re: [Bluez-users] Usage of fcntl for non blocking mode...
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1115443153=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1115443153==
Content-Type: multipart/alternative;
	boundary="----=_Part_101764_26479675.1175514698247"

------=_Part_101764_26479675.1175514698247
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Actually this code is part of bluetooth implementation of jsr82 in phonme
project.
Does making non-blocking HCI socket helps in any way for function calls such
as  hci_send_cmd ?. Or is there any other advantage ?


Regards,
Tushar



On 4/2/07, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Tushar,
>
> I never tried to have a non-blocking HCI socket. And I have no idea why
> you actually need it. It is better to use the D-Bus API anyway.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share
> your
> opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>



-- 
Tushar Paturde

------=_Part_101764_26479675.1175514698247
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Actually this code is part of bluetooth implementation of jsr82 in phonme project.<br>Does making  non-blocking HCI socket helps in any way for function calls such as&nbsp; hci_send_cmd ?. Or is there any other advantage ?<br><br>
<br>Regards,<br>Tushar<br><br><br><br><div><span class="gmail_quote">On 4/2/07, <b class="gmail_sendername">Marcel Holtmann</b> &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Tushar,<br><br>I never tried to have a non-blocking HCI socket. And I have no idea why<br>you actually need it. It is better to use the D-Bus API anyway.<br><br>Regards<br><br>Marcel<br><br><br><br>-------------------------------------------------------------------------
<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to share your<br>opinions on IT &amp; business topics through brief surveys-and earn cash<br>
<a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</a><br>_______________________________________________
<br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users
</a><br></blockquote></div><br><br clear="all"><br>-- <br>Tushar Paturde

------=_Part_101764_26479675.1175514698247--


--===============1115443153==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1115443153==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1115443153==--
