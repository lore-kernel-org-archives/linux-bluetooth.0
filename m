Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Diego Liziero <liziero.diego@unimore.it>
Reply-To: diego.liziero@unimore.it
To: Paolino paperino <vonzoltan@yahoo.it>
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <20041012162957.12307.qmail@web40614.mail.yahoo.com>
References: <20041012162957.12307.qmail@web40614.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1097675179.1075.40.camel@igno>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: [Bluez-users] problems with bytestream
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 13 Oct 2004 15:46:20 +0200

Hi Andrea,
I took a look at l2test.c and I saw that
at the beginning of each packet sent
there is a small header.

The first 32 bits are used for the sequence number
and the following 16 for the packet size.

l2test[3491]: Recevied 18 bytes
00000000: 01 00 00 00 12 00 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f
.........|seq-number | len | payload
.........| (little endian) |

However I tested it with smaller packet sizes and it seems
to work here flawlessly.

l2test -s -b 1 -N 1 XX:XX:XX:XX:XX:XX

l2test -d
l2test[3488]: Connect from XX:XX:XX:XX:XX:XX [imtu 672, omtu 672,
flush_to 65535]
l2test[3488]: Receiving ...
l2test[3488]: Recevied 1 bytes
00000000: 00                                               .
l2test[3488]: Disconnect. Success

I used csr based USB dongles with latest bluez libs & utils.

Ciao,
Diego Liziero.



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
