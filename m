Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Adding services with sdptool
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <4240E6DB.5010901@ono.com>
References: <4240E6DB.5010901@ono.com>
Content-Type: text/plain
Message-Id: <1111566161.22872.139.camel@pegasus>
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
Date: Wed, 23 Mar 2005 09:22:41 +0100

Hi,

> I have a pair of bluetooth dongles, and I want one to provide access to 
> services. I load de sdpd daemon, and then I ouse the sdtool, like this 
> "#sdptool add --channel 5 SP".
> 
> Then, with the other dongle I try to discover the services, using 
> "#sdptool browse", but I get an error message: "Can't acces to remote 
> host: File not found" or "Can't acces to remote host: Host refuse 
> connection"

try to use "sdptool search --bdaddr <bdaddr> SP".

You can also check with "hcidump -X -V" what happens on your interface.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
