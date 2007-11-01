Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <307f591f0710312056r5f3f62ak42bc3cd3b8f01942@mail.gmail.com>
Date: Wed, 31 Oct 2007 19:56:36 -0800
From: "Paul Huber" <paul2004x@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-devel] multi-frequency scanning & US $2,000 'bounty'
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1658278639=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1658278639==
Content-Type: multipart/alternative;
	boundary="----=_Part_13203_18553767.1193889396742"

------=_Part_13203_18553767.1193889396742
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks for all the technical input.  I'm an experienced C coder, but don't
know much about bluetooth technical stuff.  So a lot of this went over my
head.  I'm kind of busy to learn everything I'd need to know, and don't want
to leach off the bluez devs -- I'm a coder myself, so I know the value of
everyone's time.  I have a small budget of $2,000 already approved for me to
solve this issue.  If that's not enough, let me know, and I can try to get
more approved.  Since I'm really busy with another project, I'll offer it as
a bounty if someone can provide me a solution so I don't need to invest the
time to learn all this stuff.  I was going to try to do it myself for that
amount that I quoted the client, but I realize there are too many things I
don't know, like the acceptable level of radiation, that it's better for me
just to pass it on.

First, regarding the concerns previously stated in the thread: Don't worry
about 'spamming'; the customer has to explicitly sign up online first.
There's also no concern about getting the Bluetooth logo on the box; this is
a closed system for a particular retail customer.  It's a black box
solution.  Also, there's no concern about needing to actually 'pair' with
the device that fast and transmit data; we just need to quickly detect the
phones as they pass through.  And any mods to bluez will be released under
GPL.

I'm under NDA so I can't give out all the details on the business model.
But I'll offer the bounty to anyone that can offer me the following
solution:

1)  Spec out the hardware: With a budget of no more than US $40 per unit in
quantities of 1,000, I need someone to say which USB Bluetooth dongle plus a
antenna can be used to detect mobile phones as they pass through an area
that is 6 meters x 6 meters.  I've ordered the following antenna already,
which may be all that's needed: http://www.hyperlinktech.com/web/hg2412p.php
I would send you the antenna, the dongle, etc., so you could confirm it all
works.  If it doesn't, and if you need to buy other dongles, antennas, or
other hardware to do the testing, I will pay for that in addition to the
bounty.  The hardware needs to be legal, such as not exceeding laws about
radiation, but doesn't need to be Bluetooth certified.

2)  Code the software: I need a piece of software that can detect a mobile
phone and report the bluetooth id and the mac address of the phone reliably
in 2 seconds or less when that phone is passing under the antenna at a speed
of up to 2.5 meters per second (ie a brisk walk) so that each phone will
always be detected every time as it passes through the coverage area.

The software app can just write the mac + bluetooth id to stdout as the
phones are detected.  That is sufficient for this, and I can do the rest.
I'd like the software to be in C or C++.  Ideally I'll probably use
the 2.4kernel for this since it seems lighter weight.  But I'd need
you to confirm
that the bluetooth stuff works sufficiently well on 2.4, and we can go to
2.6 if needed.  It has to be reliable and accurate and detect a standard
bluetooth phone that is not obscured by anything except perhaps fabric (ie
in a pocket) 99% of the time.

The deliverables are: 1) specify what usb dongle and antenna to use
(make/model/supplier), 2) code that compiles with 'make' and runs and
performs the tasks described.  I'd like to have the finished solution within
about 4 weeks.

If someone thinks that the requirements are doable in the time frame, I'll
get the client to provide the contract confirming payment when the
deliverables are met.  If it's not doable or will require more time/money,
let me know, and I'll try to get the client to approve more.  I told them I
thought $2k was reasonable, even though I don't really know all that's
involved.  If you e-mail me privately, I'll give you a phone number too so
you can call if you'd like to discuss.

Thanks.

------=_Part_13203_18553767.1193889396742
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks for all the technical input.&nbsp; I&#39;m an experienced C coder, but don&#39;t know much about bluetooth technical stuff.&nbsp; So a lot of this went over my head.&nbsp; I&#39;m kind of busy to learn everything I&#39;d need to know, and don&#39;t want to leach off the bluez devs -- I&#39;m a coder myself, so I know the value of everyone&#39;s time.&nbsp; I have a small budget of $2,000 already approved for me to solve this issue.&nbsp; If that&#39;s not enough, let me know, and I can try to get more approved.&nbsp; Since I&#39;m really busy with another project, I&#39;ll offer it as a bounty if someone can provide me a solution so I don&#39;t need to invest the time to learn all this stuff.&nbsp; I was going to try to do it myself for that amount that I quoted the client, but I realize there are too many things I don&#39;t know, like the acceptable level of radiation, that it&#39;s better for me just to pass it on.
<br><br>First, regarding the concerns previously stated in the thread: Don&#39;t worry about &#39;spamming&#39;; the customer has to explicitly sign up online first.&nbsp; There&#39;s also no concern about getting the Bluetooth logo on the box; this is a closed system for a particular retail customer.&nbsp; It&#39;s a black box solution.&nbsp; Also, there&#39;s no concern about needing to actually &#39;pair&#39; with the device that fast and transmit data; we just need to quickly detect the phones as they pass through.&nbsp; And any mods to bluez will be released under GPL.
<br><br>I&#39;m under NDA so I can&#39;t give out all the details on the business model.&nbsp; But I&#39;ll offer the bounty to anyone that can offer me the following solution:<br><br>1)&nbsp; Spec out the hardware: With a budget of no more than US $40 per unit in quantities of 1,000, I need someone to say which USB Bluetooth dongle plus a antenna can be used to detect mobile phones as they pass through an area that is 6 meters x 6 meters.&nbsp; I&#39;ve ordered the following antenna already, which may be all that&#39;s needed: 
<a href="http://www.hyperlinktech.com/web/hg2412p.php">http://www.hyperlinktech.com/web/hg2412p.php</a>&nbsp;&nbsp; I would send you the antenna, the dongle, etc., so you could confirm it all works.&nbsp; If it doesn&#39;t, and if you need to buy other dongles, antennas, or other hardware to do the testing, I will pay for that in addition to the bounty.&nbsp; The hardware needs to be legal, such as not exceeding laws about radiation, but doesn&#39;t need to be Bluetooth certified.
<br><br>2)&nbsp; Code the software: I need a piece of software that can detect a mobile phone and report the bluetooth id and the mac address of the phone reliably in 2 seconds or less when that phone is passing under the antenna at a speed of up to 
2.5 meters per second (ie a brisk walk) so that each phone will always be detected every time as it  passes through the coverage area.<br><br>The software app can just write the mac + bluetooth id to stdout as the phones are detected.&nbsp; That is sufficient for this, and I can do the rest.&nbsp; I&#39;d like the software to be in C or C++.&nbsp; Ideally I&#39;ll probably use the 
2.4 kernel for this since it seems lighter weight.&nbsp; But I&#39;d need you to confirm that the bluetooth stuff works sufficiently well on 2.4, and we can go to 2.6 if needed.&nbsp; It has to be reliable and accurate and detect a standard bluetooth phone that is not obscured by anything except perhaps fabric (ie in a pocket) 99% of the time.
<br><br>The deliverables are: 1) specify what usb dongle and antenna to use (make/model/supplier), 2) code that compiles with &#39;make&#39; and runs and performs the tasks described.&nbsp; I&#39;d like to have the finished solution within about 4 weeks.
<br><br>If someone thinks that the requirements are doable in the time frame, I&#39;ll get the client to provide the contract confirming payment when the deliverables are met.&nbsp; If it&#39;s not doable or will require more time/money, let me know, and I&#39;ll try to get the client to approve more.&nbsp; I told them I thought $2k was reasonable, even though I don&#39;t really know all that&#39;s involved.&nbsp; If you e-mail me privately, I&#39;ll give you a phone number too so you can call if you&#39;d like to discuss.
<br><br>Thanks.<br>

------=_Part_13203_18553767.1193889396742--


--===============1658278639==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============1658278639==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1658278639==--
