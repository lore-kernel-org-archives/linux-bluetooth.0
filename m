Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Nate Delage <nate@natedelage.com>
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1125077053.11411.7.camel@slim>
Mime-Version: 1.0
Subject: [Bluez-devel] Belkin F8T020 adapter
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 26 Aug 2005 10:24:13 -0700

Hi...

I just got a Belkin F8T020 adapter. It is a CF card but comes with a
PCMCIA adaptor as well. The card doesn't seem to be supported under
Linux. I've loaded all the bluetooth modules after compiling them from
the latest kernel patch (patch-2.6.12-mh3.gz)

Two other individuals have already asked about this device, but it
doesn't seem they reached any conclusions...

http://sourceforge.net/mailarchive/forum.php?thread_id=1878907&forum_id=1881

http://sourceforge.net/mailarchive/forum.php?thread_id=1878907&forum_id=1881

After inserted the card I don't have any indication that Linux sees the
card (nothing from dmesg or lspci).

Does anyone know the status of this card? Or have any suggestions on how
to proceed? I'm more than willing to do any sort of debugging
necessary...

-Nate





-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
