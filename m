Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Jonathan Sass <jsass@magnifeye.com>
In-reply-to: <1102627652.7962.4.camel@pegasus>
To: bluez-users@lists.sourceforge.net
Message-id: <8EEDF252-6988-11D9-A39A-000D9348D4BE@magnifeye.com>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII; format=flowed
References: <41B8A67C.3060608@paytec.com> <1102627652.7962.4.camel@pegasus>
Subject: [Bluez-users] Permissions on Sockets
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
Date: Tue, 18 Jan 2005 11:38:41 -0800

My application connects to a custom device.  The app works when I run 
as su but I get an error from hci_send_cmd from the writev(dd, iv, ivn) 
when I run as a regular user.

Are there some permissions that I need to set to allow my regular user 
to write to the socket?

Thank you,

Jonathan



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
