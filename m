Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Steven Yap <syap@shaw.ca>
Subject: Re: [Bluez-users] Trouble connecting to a Sony Ericsson T610 phone.
In-reply-to: <cone.1089163591.829830.5657.500@commodore.email-scan.com>
To: bluez-users@lists.sourceforge.net
Message-id: <1089275408.4954.39.camel@obsolescence>
MIME-version: 1.0
Content-type: text/plain
References: <cone.1089163591.829830.5657.500@commodore.email-scan.com>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 08 Jul 2004 01:30:08 -0700

On Tue, 2004-07-06 at 18:26, Sam Varshavchik wrote:
> I'm using a Belkin USB dongle to try to connect to my T610 phone.  I'm 
> running bluez 2.5 on Fedora Core 2 x86_64.

I have a T616 and running Debian "sid" with bluez 2.7 on x86.

> "hcitool scan" does list the phone.  And the "Add New Device" option on the 
> phone does show the PC, after a brief delay.  But if I tell the phone to go 
> ahead and connect to the PC, enter a PIN, the phone spins for a while, then 
> reports "Bluetooth connection failed" .  On the PC side nothing happens.

Did you install a PIN helper like bluez-pin to let you enter a PIN
value for pairing? 

-- 
Steven Yap <syap@shaw.ca>


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
