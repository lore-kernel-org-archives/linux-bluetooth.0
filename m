Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1d1502880701122216v187542ecx45af28f4da86323e@mail.gmail.com>
References: <1d1502880701122216v187542ecx45af28f4da86323e@mail.gmail.com>
Date: Mon, 15 Jan 2007 14:27:30 +0100
Message-Id: <1168867650.5728.11.camel@violet>
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

Hi,

>  I am doing an experiment to transfer file from Cellphones to Linux
> over BT
> using BlueZ stack available in Linux.
> 
> Object Push from Nokia 93 to BlueZ fails.
> 
> 1) I am able to push a file from Motorola to Linux BlueZ. 
> 
> 2) But I am unable to push a file from Nokia N93 to Linux BlueZ.
> 
> Error message displayed on Nokia 93 is "Unable to Connect".
> 
> Can anyone help me, in identifying what's going wrong from the log
> attached 
> below? Since I am new to BT, I am not yet become expert in
> understanding the
> BT protocol. There is something going wrong from Linux BlueZ stack,
> when Nokia
> cellphone is sending file transfer request.
> 
> 3) I also tried transferring files from Linux to Nokia, which works
> fine. 
> 
> HciDumps for both the file pushes are given below

the MotoQ dump doesn't show any OBEX nor RFCOMM activity. The Nokia dump
indicates that no RFCOMM server is listening on channel 9.

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
