Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Buetooth Printserver
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <loom.20050113T121909-801@post.gmane.org>
References: <loom.20050113T121909-801@post.gmane.org>
Content-Type: text/plain
Message-Id: <1105617180.7961.193.camel@pegasus>
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
Date: Thu, 13 Jan 2005 12:53:00 +0100

Hi Michael,

> I am using the testing branch of Debian. I installed bluez-cups to print.
> To start with, connecting my printer via USB cables works fine and it is easy 
> to install via browser or KDE printer setup. But as soon as I switch to 
> bluetooth the problem starts.
> All bluetooth parts are recognized correctly (hcitools dev and scan display the 
> usb bluetooth dongle in my pc and the bluetooth printserver correctly).
> 
> Documentation concerning bluetooth printing starts only with the URI syntax. 
> But there is no hint, howto or guide explaining the steps before. How do I 
> start to setup the bluetooth printer connection. Where can I find such a 
> description?
> 
> Apart from that, using the CUPS setup via browser and localhost:631 does not 
> display the bluetooth interface in the interface list (although bluez-cups is 
> installed).

try to install a network printer and then enter the Bluetooth URI when
requested to specify your printer. That's all.

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
