Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Andrew Kohlsmith <akohlsmith-bluez@benshaw.com>
To: bluez-users@lists.sourceforge.net
Date: Wed, 10 Jan 2007 12:12:51 -0500
References: <042F6BC7-A46A-4D9D-8810-1C66347B60C7@gmail.com>
	<45A51999.3010108@xmission.com>
	<1A3C202B-4795-4352-8B71-26F102A84F2E@gmail.com>
In-Reply-To: <1A3C202B-4795-4352-8B71-26F102A84F2E@gmail.com>
MIME-Version: 1.0
Message-Id: <200701101212.51800.akohlsmith-bluez@benshaw.com>
Subject: Re: [Bluez-users] What happened with pin_helper (hcid.conf)?
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

On Wednesday 10 January 2007 11:56 am, Bas Schulte wrote:
> hcid complains when I do just that:
>
> Jan 10 17:56:27 localhost hcid[8326]: Unknown option 'pin_helper'
> line 26

I just use "passkey 0000;" and security auto.  It seems to be the New Way if 
you don't want to use dbus.

-A.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
