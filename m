Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Kill l2test server
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <2de4657605011007106fbd81e8@mail.gmail.com>
References: <2de4657605011007106fbd81e8@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1105370509.8652.24.camel@pegasus>
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
Date: Mon, 10 Jan 2005 16:21:49 +0100

Hi Manjunath,

> For the l2test, is there a cleaner method to kill the listening
> receiver. I am using CTRL+C right now. I am trying to kill the active
> socket....using close(s1)...but it doesn't seem to be working.
> I want a clean exit.

what do you wanna kill? The active connection or the listening socket?
If you wanna separate them, then you need to add somekind of signal
handling.

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
