Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Securing my bluetooth connection
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1105899721.5669.12.camel@localhost.localdomain>
References: <1105899721.5669.12.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1105901392.8080.21.camel@pegasus>
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
Date: Sun, 16 Jan 2005 19:49:52 +0100

Hi Phil,

> I have set up my bluetooth connection on Fedora core 3 so that I can
> connect my Palm Pilot. I just needed to add the sdpd line to rc.local
> after moving from core 2.
> 
> My configuration is below.
> 
> A couple of questions
> How do I configure it so that only my palm pilot can connect, I have
> tried putting my mac address into rfcomm.conf, but I can still connect
> when I set it wrong.

you need to modifiy the source of dund for that.

> How do I make the PC not discoverable, I know the chances of being
> scanned by someone standing on the pavement outside is not as likely as
> being bluejacked in Tescos or the pub, but it could happen.

Disable the inquiry scan (iscan).

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
