Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Fredrik Tolf <fredrik@dolda2000.com>
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1124215347.21719.31.camel@pc7.dolda2000.com>
Mime-Version: 1.0
Subject: [Bluez-devel] Headset reconnection
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
Date: Tue, 16 Aug 2005 20:02:27 +0200

Hi!

I'm wondering about how BT headsets and mobile phones usually work
together, in hope of implementing automatic connection in btsco.

Normally, it seems that a mobile phone and a headset manage to keep
their link, even across "reboots" and other disconnections. Does a phone
periodically scan for headsets that it knows, or does the headset
somehow try to automatically reconnect to the phone under certain
circumstances, or is it something completely different?

Can anyone tell me where to find info on this?

Fredrik Tolf




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
