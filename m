Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] hcidump and l2cap questions
From: Marcel Holtmann <marcel@holtmann.org>
To: Sean Loh <blaze_wk@yahoo.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20041017154240.40997.qmail@web41106.mail.yahoo.com>
References: <20041017154240.40997.qmail@web41106.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1098029144.4911.99.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 17 Oct 2004 18:05:44 +0200

Hi Sean,

> 1. Does that mean that bluez constantly fragments all
> upperlayer protocols to a max of 1500 bytes?

this is only specific if you use BNEP, because it is an Ethernet
emulation and you can use IP on top of it.

> 2. What does the parameters of these hcidump mean?
> 1098027478.336048 < BNEP: Compressed(0x02|0)
>     [proto 0x0800]

I haven't looked up the protocol value for 0x0800, but I guess you get a
BNEP packet with an IP frame as payload.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
