Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Kill l2test server
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <2de4657605011008282db8603b@mail.gmail.com>
References: <2de4657605011007106fbd81e8@mail.gmail.com>
	 <1105370509.8652.24.camel@pegasus>
	 <2de4657605011008282db8603b@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1105388674.8652.50.camel@pegasus>
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
Date: Mon, 10 Jan 2005 21:24:34 +0100

Hi Manjunath,

> The active connection is killed once the client(sender) exits. I want
> to kill the listening socket....how can i do this?

with the current code this is impossible. However for what do you think
this is good?

> when i pump 5000 packets continously .....the connection
> closes down after some 2000 odd packets ...is this because of hci
> buffer getting full and some kind of queue or buffer overflow??

Show us your code. I have no idea what that is so.

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
