Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] how to obtain address for rfcomm connection
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1106148402.12428.21.camel@justakiss>
References: <1106148402.12428.21.camel@justakiss>
Content-Type: text/plain
Message-Id: <1106154308.8190.128.camel@pegasus>
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
Date: Wed, 19 Jan 2005 18:05:08 +0100

Hi Erwin,

> I want to establish a rfcomm connection to a mobile phone. I don't know
> the phone's address or name a-priori. The pairing is initated from the
> phone before the rfcomm connection is initiated. Is there an easy way to
> get the phone's address from the preceding link key exchange (from
> /etc/bluetooth/link_key?). Browsing/scanning for devices might give more
> than one canditate for communication, but I want to use only the one
> that has already paired.

you will find any paired device in the link_key file. However if the
phone was connected then you can use normal technics to get the device
address at the that time. To what service did the phone connect?

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
