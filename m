Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <37aae5740711080854vcc13070ldca32b942aa6508f@mail.gmail.com>
Date: Thu, 8 Nov 2007 17:54:24 +0100
From: "=?ISO-8859-2?Q?Daniel_Kuku=B3a?=" <daniel.kuku@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_44023_29674433.1194540864704"
Subject: [Bluez-devel] patch for my usb dongle
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

------=_Part_44023_29674433.1194540864704
Content-Type: multipart/alternative;
	boundary="----=_Part_44024_15909145.1194540864704"

------=_Part_44024_15909145.1194540864704
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've found a patch for my noname USB bluetooth dongle - could someone
forward it to the bluetooth kernel maintainer ?
(I don't know where to send it, so I send it here)

the output of lsusb gives me this

kuku@kuku ~ $ sudo lsusb
Bus 003 Device 001: ID 0000:0000
Bus 002 Device 001: ID 0000:0000
Bus 001 Device 005: ID 0e5e:6622
Bus 001 Device 003: ID 058f:6362 Alcor Micro Corp. Hi-Speed 21-in-1 Flash
Card Reader/Writer (Internal/External)
Bus 001 Device 002: ID 05e3:0608 Genesys Logic, Inc. USB-2.0 4-Port HUB
Bus 001 Device 001: ID 0000:0000

(usb module is on Bus 001 dev 005)

Regards

------=_Part_44024_15909145.1194540864704
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I&#39;ve found a patch for my noname USB bluetooth dongle - could someone forward it to the bluetooth kernel maintainer ?<br>(I don&#39;t know where to send it, so I send it here)<br><br>the output of lsusb gives me this<br>
<br>kuku@kuku ~ $ sudo lsusb<br>Bus 003 Device 001: ID 0000:0000<br>Bus 002 Device 001: ID 0000:0000<br>Bus 001 Device 005: ID 0e5e:6622<br>Bus 001 Device 003: ID 058f:6362 Alcor Micro Corp. Hi-Speed 21-in-1 Flash Card Reader/Writer (Internal/External)
<br>Bus 001 Device 002: ID 05e3:0608 Genesys Logic, Inc. USB-2.0 4-Port HUB<br>Bus 001 Device 001: ID 0000:0000<br><br>(usb module is on Bus 001 dev 005)<br><br>Regards<br>

------=_Part_44024_15909145.1194540864704--

------=_Part_44023_29674433.1194540864704
Content-Type: application/x-gzip; name=hci_usb.c.patch.gz
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f8rii9le0
Content-Disposition: attachment; filename=hci_usb.c.patch.gz

H4sICLOU/kYCA2hjaV91c2IuYy5wYXRjaACNkE1PwkAURdf0V9yl0k55DF+FxKShVm2MNKGgy0lh
RpjY0KaliDH+d1uNIQFimM2bzbnn3ccYw3qpRVks7KWdJrLBiQaMhowP0e6NaDDqOjb9PTDqEBmm
aR6oY8IZ8e4J4bpgbe5YfZj1GMJ1DTQ+MY/G4tZ/Djz/ivbUJbJQTYcG1xZsmeudyoXevKa4wYMX
iPE0fPQnIohCD1/WvwnxZQmG2Wg1MU5KhShNlE6wiAslEcs426oc73q7xqJcrT4QeSGKMsvSfItm
qwKP5aqnanm/z/lFcrMqUMtV8qY3uHNm1OaIN/L324FUO71URS07bdoj+dO0Ys7LXqbh5F5US4un
2fz8tQ4ZnQszvgFKI0RkMAIAAA==
------=_Part_44023_29674433.1194540864704
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
------=_Part_44023_29674433.1194540864704
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_Part_44023_29674433.1194540864704--
