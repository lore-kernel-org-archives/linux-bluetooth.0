Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42C2DA3D.3020808@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Odd inquiry scan result
References: <20050629163820.10206.qmail@web30711.mail.mud.yahoo.com>
In-Reply-To: <20050629163820.10206.qmail@web30711.mail.mud.yahoo.com>
Content-Type: text/plain; charset="us-ascii"
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
Date: Wed, 29 Jun 2005 18:28:29 +0100

Olivier Randriamanana wrote:
>> HCI Event: 0x0e plen 8
>   01 1D 0C 12 00 00 00 00

Event 0e:    Command Complete
01:          num_hci_command_packets = 1
1D 0C:       Opcode 0x0c1d = Read Inquiry Scan Activity
12:          Status = Invalid HCI command parameters !
00 00 00 00: Parameters = not valid as there was an error !

See the 10 commandments of C by Henry Spencer at:

  http://www.lysator.liu.se/c/ten-commandments.html

Commandment 6:

  If a function be advertised to return an error code in the event of
  difficulties, thou shalt check for that code, yea, even though the
  checks triple the size of thy code and produce aches in thy typing
  fingers, for if thou thinkest ``it cannot happen to me'', the gods
  shall surely punish thee for thy arrogance.

In this case for "function ... return" read "event ... contain".

[...]
>   len = READ_INQ_ACTIVITY_RP_SIZE;
[...]
>   if (hci_send_cmd(dd, ogf, ocf, len, ptr /*buf*/) < 0) {

Would I be right in thinking that READ_INQ_ACTIVITY_RP_SIZE is the
size of the response and not the size of the command?

You should be passing the size of the command parameters (0) here.

Confirm that the command that was sent was correct by looking at an
hcidump log.

	- Steven
-- 


**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

**********************************************************************



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
