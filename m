Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4378BD70.8060002@libero.it>
From: jimmi <jimmi@libero.it>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: hcid crashing on pin_code_request
References: <200511141452.23951.Dubitzky@physi.uni-heidelberg.de> <200511141705.51539.Dubitzky@physi.uni-heidelberg.de>
In-Reply-To: <200511141705.51539.Dubitzky@physi.uni-heidelberg.de>
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
Date: Mon, 14 Nov 2005 17:38:08 +0100

* Rolf S. Dubitzky  il 14/11/05 alle 17,05 ha scritto:
 >  # /usr/local/bin/btsco -v -r -s 00:07:A4:03:97:24
 >  btsco v0.4c
 >  Device is 1:0
 >  Error: Failed to connect to SDP server: Connection timed out
 >  Assuming channel 2
 >
 >  Voice setting: 0x0060
 >  Can't connect RFCOMM channel: Resource temporarily unavailable

I fixed this problem by including:
         auth disable;
         encrypt disable;
in /etc/bluetooth/hcid.config. I hope ot works for you too :)
--
    ---         _   o       | If God had intended man to use the metric |
    / immi   ---  _/\_>     |   system, Jesus would have only had ten   |
(_/          -  O,> / O    |                disciples.                 |


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
