Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20041013143813.89912.qmail@web40626.mail.yahoo.com>
From: Paolino paperino <vonzoltan@yahoo.it>
To: bluez-users@lists.sourceforge.net
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <1097675179.1075.40.camel@igno>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-devel] Re: [Bluez-users] problems with bytestream + rfcomm socket problems
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
Date: Wed, 13 Oct 2004 16:38:13 +0200 (CEST)

Thanks Diego,
Now i've tested the rctest (without the usleep that
i've inserted) on a machine with kernel 2.4.18 and
bluez libs/utils 2.2(USB dongle digicom), and the
receive function doesn't give any prblems, work well,
doesn't loose any byte...is this a bug in the kernel i
use?!

PS The USB dongle i use with the kernel 2.6 is a Trust
BT180

Thanks 
Andrea S.



		
___________________________________ 
Nuovo Yahoo! Messenger: E' molto più divertente: Audibles, Avatar, Webcam, Giochi, Rubrica… Scaricalo ora! 
http://it.messenger.yahoo.it


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
