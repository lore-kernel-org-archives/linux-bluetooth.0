Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Jean Tourrilhes <jt@hpl.hp.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20050112183806.GE31615@bougret.hpl.hp.com>
References: <20050112183806.GE31615@bougret.hpl.hp.com>
Content-Type: text/plain
Message-Id: <1105561978.7961.140.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: out of range
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 12 Jan 2005 21:32:58 +0100

Hi Jean,

> > I think there is no way to differ between it yet. Feel free to propose
> > an idea how that should be done within the normal socket operation.
> 
> 	Marcel : I did propose to you a scheme to detect out of range
> conditions ahead of the Supervision Timeout that would clearly also
> work for this.

I had your patch in my -mh patches for some time, but then it got out of
sync with the mainline development and I dropped it. However I want your
patch inside the kernel, but I still don't like the way of notification.
What do you think about setting sk->sk_err with an error code like we do
for the reliable feature that detects ACL packet errors. Even if the HCI
events itself are global I like to do the notification through the
socket interfaces of L2CAP and RFCOMM. Comments?

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
