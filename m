Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-Id: <5.1.0.14.2.20030425084856.1095eb30@unixmail.qualcomm.com>
To: bluez-devel@lists.sourceforge.net
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-users] Re: [Bluez-devel] DB aliases (wishlist)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 25 Apr 2003 08:49:20 -0700

At 12:56 AM 4/9/2003, David Woodhouse wrote:
>On Mon, 2003-04-07 at 22:43, Marcel Holtmann wrote:
>> So this is a basic request to all of you. What do you want to see in the
>> next version of the BlueZ utils?
>
>Link key management.
>
>hcitool lk list [<dev>|<bdaddr>] [<bdaddr>]
>hcitool lk remove [<dev>|<bdaddr>] <bdaddr>...
>hcitool lk add [<dev>|<bdaddr>] <bdaddr> <key>
>hcitool lk merge <filename>
>
>See xauth :)
>
>I'm tired of manually copying link keys from /etc/bluetooth/link_key
>from one machine to another when I move the CF Bluetooth card. I want to
>be able to 'hcitool lk list | ssh ipaq hcitool lk merge -' ;)
>
>OK, so buying another card would also help, but even so we do need at
>least the 'hcitool lk remove' functionality and 'lk list' would be very
>useful too.
>
>As previously discussed, it would be nice if non-root users could see
>the results of 'lk list' without the actual keys -- basically just a
>list of devices with which we're paired.
Yep. I had something similar in mind.

>/etc/bluetooth/paired_devices and /etc/bluetooth/paired_devices.shadow, anyone? :)
        /etc/bluetooth/
                neighbours (world readable) - <bdaddr>, <name>, <last seen>, etc
                security                    - <bdaddr>, <pin code>, <link key>


Max
 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
