Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <490dd6310611241234le826f35v5344eb16943b043e@mail.gmail.com>
References: <490dd6310611241234le826f35v5344eb16943b043e@mail.gmail.com>
Date: Sun, 26 Nov 2006 11:11:57 +0100
Message-Id: <1164535917.25914.5.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Blank events file
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

Hi Andy,

> I've been trying to get a wiimote to work with linux and have been
> able to connect to it using hidd and an eventX file is created in
> /dev/input/ but when I try to read from it I get no data. Using
> hicdump I can recieve data on button presses so I would think that
> data should be sent to the event file and I was wondering why it's
> not.
> 
> I don't know if it's important but towards the end of the connection
> output from hcidump and right after the "HIDP: Set protocol: Boot
> protocol" request I get the following message:
>     > ACL data: handle 46 flags 0x02 dlen 5
>         L2CAP(d): cid 0x0040 len 1 [psm 17]
>           HIDP: Handshake: Unsupported request

you might wanna try my -mh kernel patch with the HID report mode
protocol support.

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
