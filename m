Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <436DB826.2090406@libero.it>
From: jimmi <jimmi@libero.it>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] btsco + aplay produces only silence on headset
References: <17261.23534.882674.809679@waldo.lisle.iphase.com>
In-Reply-To: <17261.23534.882674.809679@waldo.lisle.iphase.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Sun, 06 Nov 2005 09:00:38 +0100

* bradbosch@comcast.net il 05/11/05 alle 19,27 ha scritto:
 > Greetings,
 >
 > I hope someone here can tell me what I might be doing wrong. I have no
 > problems  pairing various  headsets with  my computer  and the  volume
 > controls and other buttons produce the expected results. I hear a beep
 > when I start aplay, but no other sound is produced. I've been thru the
 > mail list archives but none of the hints I've found there have helped.

It  looks like  you have  the alsa  module separate:  the bluetooth-alsa
page  tells that  you need  "a recent  (2.6.11.7 or  newer) kernel  with
*integrated* alsa  enabled", therefore you  cannot use the  debian image
but recompile the source.

--
    ---         _   o       |     Sembra di sentirlo ancora dire al     |
    / immi   ---  _/\_>     | mercante di liquori: tu che lo vendi cosa |
(_/          -  O,> / O    |        ti compri di migliore? FdA         |



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
