Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <1302.213.112.80.112.1097230559.squirrel@webmail.nada.kth.se>
From: alexj@nada.kth.se
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Subject: [Bluez-users] Scan Time for hcitool
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
Date: Fri, 8 Oct 2004 12:15:59 +0200 (MEST)

Dear list,

I'm using hcitool to search for a number of known HW-addresses, to see of
someones in the (coffee)room. Corny, but fun.
Example:
hcitool name DE:39:EF:98:01:34

However, If all phones/devices are present, the script runs quickliy,
traversin through the list. But, if one is missing it takes a very long
time before it terminates. Setting a timeoutflag, doesn't seem to do the
trick. And I can't spawn more cild processes, because the first one locks
up the HCi device, of course.

What can be done to shorten the seek->timeout time for non-present devices
that have known HW-addresses?

sincerely

Alex




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
