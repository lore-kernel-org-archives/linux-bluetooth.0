Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] multiple BT dongles
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <41E6ED75.2060800@gmx.ch>
References: <18514.1105613960@www29.gmx.net>
	 <1105614296.7961.162.camel@pegasus>  <41E6ED75.2060800@gmx.ch>
Content-Type: text/plain
Message-Id: <1105687666.7525.13.camel@pegasus>
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
Date: Fri, 14 Jan 2005 08:27:46 +0100

Hi Marco,

> > you can assign the services (application like pand) for each dongle, but
> > right now you can't make the sdpd differ between them.
> 
> I think we talk about the same thing, but just to get shure:
> If i program two different rfcomm services, that would mean that i can 
> control which service runs on which dongle?

if you use the RFCOMM socket then you simply bind() the socket to a
specific BD_ADDR of a local dongle.

> > Every CSR dongle with at least HCI 16.4 firmware.
> 
> Is the firmware updateable?

Yes.

> Do i have to contact the manufacturer?

Yes.

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
