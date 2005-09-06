Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <431DC228.7030309@infomatrix.com>
From: Ben Tullis <ben.tullis@infomatrix.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] I have a question about the bdaddr utility
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
Date: Tue, 06 Sep 2005 17:22:00 +0100

Hello again,

Maybe this should be directed at bluez-devel, but I'll ask anyway.
I have a question about the bdaddr utility, with reference to a CSR 
chipset, connected via internal USB on a Sony Vaio
According to the list, this utility is able to change the bluetooth 
address of a particular device.

My question is, is this change permanently written to the chip, or is it 
merely a volatile change as far as the running kernel is concerned?

The reason I ask is that I am having trouble with dual-booting between 
Windows XP and Linux. I have to repair each time I swap operating 
systems and it is a pain.

It seems to me that the easiest way to get it to work is to convince the 
kernel to use a different bluetooth address when initialising the 
device. I could then have two pairings on my phone. Hey presto.

If the bdaddr utility writes this change to the chip, then that's no 
good for this situation. Is there any other way in which this could be 
achieved?
Should it be necessasry at all? Are the link keys etc. stored on the 
chip in order to be o/s independent anyway?

The phone is a Nokia 6680
The kernel is 2.6.13-mh1
bluez-utils/libs are at 2.19

Many thanks.

Ben Tullis


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
