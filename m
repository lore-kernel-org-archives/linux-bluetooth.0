Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20050830050012.1059BA0286@bostoncoop.net>
From: nrbutler@bostoncoop.net (Nat Butler)
Subject: [Bluez-devel] Re: a2play and rtc/pthread
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
Date: Tue, 30 Aug 2005 01:00:11 -0400 (EDT)

Hi Brad,

I tried the new a2play code on my Motorola HT820.

> I just committed changes to a2play so it can use the real time clock
> inside a separate thread for sending frames to the headset. Please try
> it out. (flag is -p)
>
> The values to tweak are TICKS and the first "100" in the frameticks
> assignment.

I'm finding that the sound cuts out after about 10 seconds of playing an mp3 with -p.  I haven't found a value to replace the 100 which corrects that.  

Per a previous suggestion of yours, I tried using different values from 87 for the itimer option.  A value of 84 seems to work decently with this headset.  The sound cuts out for a fraction of a second every 15 seconds or so.  I was unable to improve this with different values or by using a range of values with either the -t or -t -t options.  

-Nat


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
