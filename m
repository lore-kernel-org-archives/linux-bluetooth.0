Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <adf2d65c0611180540k7324b6bfxcf298321d2765c21@mail.gmail.com>
Date: Sat, 18 Nov 2006 14:40:39 +0100
From: Arthur <avandorp@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <20061118121407.87181.qmail@web52109.mail.yahoo.com>
MIME-Version: 1.0
References: <20061118121407.87181.qmail@web52109.mail.yahoo.com>
Subject: Re: [Bluez-users] Errors pairing with headset
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0335245945=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0335245945==
Content-Type: multipart/alternative;
	boundary="----=_Part_12910_15242321.1163857239783"

------=_Part_12910_15242321.1163857239783
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>
> Then, googling a bit, I thught I should load the snd_bt_sco module,


Ah, sorry, forgot about that. Just add it snd_bt_sco to your /etc/modules to
make it load at boot time.

after i did that, the btsco -v command above gives me back
>
>     btsco v0.42
>     Device is 1:0
>     Error: Failed to connect to SDP server: Permission denied
>     Assuming channel 2
>
>     Voice setting: 0x0060
>     Can't connect RFCOMM channel: Permission denied
>
> What do I miss?


I'd say that's where you should get asked for the pin. I'm using KDE
together with kbluetoothd. There's also a process 'sdpd' running which
handles service discovery (as far as I know). I can't remember having
configured those manually. "/etc/init.d/bluez-utils start" gets called at
startup. Also check with the documentation of your headset on how to
initiate pairing. More doesn't come to my mind for the moment.

Regards

Arthur

------=_Part_12910_15242321.1163857239783
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Then, googling a bit, I thught I should load the snd_bt_sco module, </blockquote><div><br>
Ah, sorry, forgot about that. Just add it snd_bt_sco to your /etc/modules to make it load at boot time. <br><br></div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
after i did that, the btsco -v command above gives me back<br><br>&nbsp;&nbsp;&nbsp;&nbsp;btsco v0.42<br>&nbsp;&nbsp;&nbsp;&nbsp;Device is 1:0<br>&nbsp;&nbsp;&nbsp;&nbsp;Error: Failed to connect to SDP server: Permission denied<br>&nbsp;&nbsp;&nbsp;&nbsp;Assuming channel 2<br><br>&nbsp;&nbsp;&nbsp;&nbsp;Voice setting: 0x0060
<br>&nbsp;&nbsp;&nbsp;&nbsp;Can't connect RFCOMM channel: Permission denied<br><br>What do I miss?</blockquote><div><br>I'd say that's where you should get asked for the pin. I'm using KDE together with kbluetoothd. There's also a process 'sdpd' running which handles service discovery (as far as I know). I can't remember having configured those manually. &quot;/etc/init.d/bluez-utils start&quot; gets called at startup. Also check with the documentation of your headset on how to initiate pairing. More doesn't come to my mind for the moment.
<br><br>Regards<br><br>Arthur<br></div><br></div><br>

------=_Part_12910_15242321.1163857239783--


--===============0335245945==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0335245945==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0335245945==--
