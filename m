Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <406C1E19.7090003@ntlworld.com>
From: Oli Ellis <oliver.ellis@ntlworld.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-users] RE: Logitech multimedia keys off by one
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
Date: Thu, 01 Apr 2004 14:50:17 +0100

Yes, I tried the same -1 trick, but it seems more complicated than that. 
The event should tally with what is written on the keyboard, and I don't 
think that bluetooth devices can be released unless they are fully 
compliant (I have been reading up!). Plus, if Logitech can't get it 
right, who can? Marcel suggested it could be an error with the parser, 
but this looks to be beyond my programming expertise.

Also, a question to Mr Holtmann: The latest release of the Bluez package 
with bluez-libs-2.6 and bluez-utils-2.6 - does this negate the need for 
the CVS version for tools like hid2hci and bthid?

Thanks

- Oli


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
