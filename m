Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Anthony Yulo" <strikewing16th@hotmail.com>
To: bluez-devel@lists.sourceforge.net, blueinfo@yahoogroups.com
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law11-F108gLzhVOJwn00013a60@hotmail.com>
Subject: [Bluez-devel] Bluetoooth and Threads?
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
Date: Fri, 09 Jan 2004 03:38:09 +0000

Hi!

I'm just wondering if multiple threads can have their own bluetooth stack?

I'm planning of a single program that uses threads, one thread does only 
device discovery.. and then store the devices on a list/queue.. and then 
maybe a couple of threads that reads from  the queue and send data from the 
devices on the queue using RFCOMM.. maybe i can have seven threads since 
this is the maximum number bluetooth allows...

is this possible?

_________________________________________________________________
Add photos to your messages with MSN 8. Get 2 months FREE*. 
http://join.msn.com/?page=features/featuredemail



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
