Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] LMP format
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050108182223.0C92123CF7@ws5-3.us4.outblaze.com>
References: <20050108182223.0C92123CF7@ws5-3.us4.outblaze.com>
Content-Type: text/plain
Message-Id: <1105210082.8149.7.camel@pegasus>
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
Date: Sat, 08 Jan 2005 19:48:02 +0100

Hi Simi,

> i am trying to implement a link manager in C...
> i want to know whether LMP PDUs are generated and sent by the link manager itself or is it a part of the message sent by the Host.
> 
> 
> what i know about the LMP format is that it has fields like opcode,tranaction id and a message.
> plz correct me if i am wrong...
> 
> 
> will the link manger respond to the layers above, if it gets any message, inorder to take some actions???

the host part of the protocol stack don't deal with LMP. It uses HCI and
everything down HCI is part of the Bluetooth chip/module/dongle.

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
