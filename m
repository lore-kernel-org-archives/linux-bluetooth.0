Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <2e9fc96f0701160623i44199950u8005dc70a9176975@mail.gmail.com>
References: <1d1502880701122216v187542ecx45af28f4da86323e@mail.gmail.com>
	<1168867650.5728.11.camel@violet>
	<2e9fc96f0701160623i44199950u8005dc70a9176975@mail.gmail.com>
Date: Tue, 16 Jan 2007 15:30:00 +0100
Message-Id: <1168957800.8918.20.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Object Push from Nokia N93 to BlueZ fails
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Parbhu,

>          I started the rfcomm to listen on channel 9. Now, when I
> transfer file from Nokia N93 to my 
>          PC. 
>           It hangs. hcidump will give a segmentation fault. 
>           My configuration :
> http://gprabhunath.googlepages.com/bluez_conf
> 
>           hcidump : http://gprabhunath.googlepages.com/home
>          
>           I did the following. 
>           * Edited rfcomm.conf and hcid.conf (Ref: My configuration) 
>           * started hcid and sdpd (service bluetooth start)
>           * started rfcomm to listen on channel 9 (rfcomm -i hci0
> listen 2 9)
>           * started obexftpd (obexftpd -b -c /tmp/inbox)

you should only use obexftpd and not "rfcommm listen". The rfcomm
command will only create a TTY on successful connect, but then don't do
the needed OBEX connection for the push.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
