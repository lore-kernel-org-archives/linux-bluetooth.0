Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <307f591f0710301305n410b8ebds4fa399dd0a518840@mail.gmail.com>
Date: Tue, 30 Oct 2007 12:05:40 -0800
From: "Paul Huber" <paul2004x@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] multi-frequency scanning & possible contract work
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0548335129=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0548335129==
Content-Type: multipart/alternative;
	boundary="----=_Part_4942_6664919.1193774740291"

------=_Part_4942_6664919.1193774740291
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I need to use a directional antenna focused on an area about 6 meters x 6
meters that can scan for Bluetooth mobile phones as they pass through the
area, and identify them very quickly.  It's for a new startup business
that's focusing on a retail application running on an embedded Linux box.

The problem with the usual usb Bluetooth dongle and a normal scan is that in
a busy area with hundreds of Bluetooth phones nearby, the scan can take a
very long time, like several minutes, and will pick up lots of phones of
people all over the store.  We just want to detect them when they come in
through the entrance.  So, we're going to use a directional antenna that
focuses just on a 6 meter x 6 meter space in front of the entrance so it
doesn't pick up phones outside that area.

However there's still a problem that a traditional Bluetooth scan takes 15+
seconds to pickup devices, and that's too long.  The shopper may pass
through the detection area in only a couple seconds.  So we need to be able
to do the scans very quickly.

I don't know that much about the underlying technology, but I understand
that a typical Bluetooth scan consists of scanning across several
frequencies and hopping from frequency to frequency to find phones on each
frequency.  Therefore, my question is this: instead of having 1 bluetooth
dongle that's hopping across several frequencies, can we hook up multiple
bluetooth dongles to the same antenna, and have each one locked onto just
one frequency to make the process go faster?  In other words, can we balance
the 15 second scanning process across 5 Bluetooth dongles so we can do the
same scan in only 3 seconds?

If not, does anybody else have any suggestions for how to accomplish the end
goal of being able to very rapidly detect phones as they pass through an
area?

We do have a little bit of funding, so if something like the multi-dongle
approach method i mentioned works, and it requires some special coding or
mods to bluez, we could compensate a developer for helping out with this.

Thanks

------=_Part_4942_6664919.1193774740291
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I need to use a directional antenna focused on an area about 6 meters x 6 meters that can scan for Bluetooth mobile phones as they pass through the area, and identify them very quickly.&nbsp; It&#39;s for a new startup business that&#39;s focusing on a retail application running on an embedded Linux box.
<br><br>The problem with the usual usb Bluetooth dongle and a normal scan is that in a busy area with hundreds of Bluetooth phones nearby, the scan can take a very long time, like several minutes, and will pick up lots of phones of people all over the store.&nbsp; We just want to detect them when they come in through the entrance.&nbsp; So, we&#39;re going to use a directional antenna that focuses just on a 6 meter x 6 meter space in front of the entrance so it doesn&#39;t pick up phones outside that area.
<br><br>However there&#39;s still a problem that a traditional Bluetooth scan takes 15+ seconds to pickup devices, and that&#39;s too long.&nbsp; The shopper may pass through the detection area in only a couple seconds.&nbsp; So we need to be able to do the scans very quickly.
<br><br>I don&#39;t know that much about the underlying technology, but I understand that a typical Bluetooth scan consists of scanning across several frequencies and hopping from frequency to frequency to find phones on each frequency.&nbsp; Therefore, my question is this: instead of having 1 bluetooth dongle that&#39;s hopping across several frequencies, can we hook up multiple bluetooth dongles to the same antenna, and have each one locked onto just one frequency to make the process go faster?&nbsp; In other words, can we balance the 15 second scanning process across 5 Bluetooth dongles so we can do the same scan in only 3 seconds?
<br><br>If not, does anybody else have any suggestions for how to accomplish the end goal of being able to very rapidly detect phones as they pass through an area?<br><br>We do have a little bit of funding, so if something like the multi-dongle approach method i mentioned works, and it requires some special coding or mods to bluez, we could compensate a developer for helping out with this.
<br><br>Thanks<br><br>

------=_Part_4942_6664919.1193774740291--


--===============0548335129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============0548335129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0548335129==--
