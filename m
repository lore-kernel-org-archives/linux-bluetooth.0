Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] 2.6.10 multimedia keys
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200501032144.53762.cijoml@volny.cz>
References: <41D85BB7.5020506@comcast.net>
	 <1104698820.8894.34.camel@pegasus>  <200501032144.53762.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1104785779.8894.72.camel@pegasus>
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
Date: Mon, 03 Jan 2005 21:56:19 +0100

Hi Michal,

> Marcel pls write support for user space configuring hotkey keycodes too, 
> coz I have multimedia keys on my laptop and those keys returns other key press 
> keycodes than keys on MS desktop........than I can't configure it well, coz 
> 254 returns IE key on notebook and email key on MS desktop and so on...

some parts of this are not my job. The input guys must work on it. The
Bluetooth HIDP is only a transport layer between L2CAP and the generic
HID parser and/or the input subsystem.

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
