Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <c49421c50611291726g7256e94o3ec1283b19816cfd@mail.gmail.com>
References: <c49421c50611291726g7256e94o3ec1283b19816cfd@mail.gmail.com>
Date: Sun, 03 Dec 2006 14:49:37 +0100
Message-Id: <1165153777.19590.31.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] estimating distance between two devices
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

Hi Loreno,

> I need to someway estamate the distance between two bluetooth devices
> already connected. I thought in using RSSI for this, but RSSI, as far
> as I know, is not a mandatory feature of bluetooth. Besides, in the
> tests I have made the scale of the RSSI measurements I got had not a
> good sensibility as I moved. So now I am thinking on someway measuring
> the rate of retransmissions for estimating this. 
> 
> Well, my question is twofold: Does it make any sense the idea of
> estimating the distance through the rate of retransmissions?? and,
> does anybody would have some hint in this field??

you don't get this information without special vendor commands. The
specification only allows you to use the RSSI and Link Quality value and
while Link Quality is meant to be vendor specific, the RSSI is not, but
its usage in various Bluetooth chips is different.

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
