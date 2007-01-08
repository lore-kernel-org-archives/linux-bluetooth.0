Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Damien Bardon <damien@bardon-net.fr>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Mon, 8 Jan 2007 22:36:21 +0100
References: <200701081935.15944.damien@bardon-net.fr>
	<20070108184535.GJ16663@suse.de>
In-Reply-To: <20070108184535.GJ16663@suse.de>
MIME-Version: 1.0
Message-Id: <200701082236.21496.damien@bardon-net.fr>
Subject: Re: [Bluez-users] My device can't be detected by another one
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


Thanks a lot it is working I had to do :
# apitest SetMode discoverable

This is not very convenient, it would be better if it was integrated to 
kbluetoothd, or configurable with Yast... 

Cheers,

Damien


On Monday 08 January 2007 19:45, Stefan Seyfried wrote:
> On Mon, Jan 08, 2007 at 07:35:15PM +0100, Damien Bardon wrote:
> > perfectly detected, and I can see other devices and connect to them. The
> > problem is that other devices (I have tried with two different mobile
> > phones, one nokia and one samsung) can't see my device. Which means that
> > for example, I can send a file from my laptop to my phone, but can't send
> > a file from my phone to my laptop. My linux seems to be configured to be
> > able to be detected, but I have probably missed something and I hope you
> > can tell me what.
>
> Read /usr/share/doc/packages/bluez-utils/README.SUSE
> If there are still problems, ask again.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
