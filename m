Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] 2.6.10 multimedia keys
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <41D85BB7.5020506@comcast.net>
References: <41D85BB7.5020506@comcast.net>
Content-Type: text/plain
Message-Id: <1104698820.8894.34.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 02 Jan 2005 21:47:00 +0100

Hi Walt,

> I just updated to 2.6.10, and my media keys stopped working, hcidump 
> shows nothing.  I tried applying the mh1 patch, but that didnt help.  I 
> have the ms keyboard v1, and using the newest libs/utils.  any ideas?

actually I removed the report mode protocol support from the -mh1 patch.
I will be replaced with a better solution. The boot protocol mode has no
support for any "coffee key".

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
