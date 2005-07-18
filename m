Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Victor Shcherbatyuk <victor@win.tue.nl>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050717225345.GI3753@stusta.de>
Message-ID: <Pine.LNX.4.53.0507180927480.6913@antilope>
References: <20050717145709.GI3613@stusta.de> <1121615883.22662.38.camel@pegasus>
 <20050717225345.GI3753@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Bluez-devel] usb/sco problems
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
Date: Mon, 18 Jul 2005 09:55:54 +0100 (MET)

Hello Marcel,

I have a small app which routes back sco data received from a 
headset, so basically you supposed to hear yourself back in the headset. 
It works fine with the voice setting 0x0060, but when I switch to u-law 
0x014c sound is starting to break out, if I run the program on arm using 
uart it works fine for both of the settings.
 
Using hcidump shows a regular pattern of sco receives/sends (normally like 
3 packets in, 3 packets out, which is probably the result of usb buffering 
for incoming packets), but if I look at the output of an air-sniffer, I 
see that the data sent back to the headset has very 
irregular time pattern (a lot of transmissions are missing), while the 
time pattern of incoming data from the headset is ok.
So it looks like something goes wrong after the sco data is supplied to 
the hci_usb. I have this problems with 2 dongles I have (BC4 and 
Broadcom built-in in my laptop), so does not look as a dongle problem. Any 
idea what might be wrong?

Well, I also have a app which does copying data received from a phone 
sco to a headset sco and back (2 sco channels open and app functions as a 
middle agent). This app is also working for arm via UART, but not on my 
laptop (and home pc) via usb. The question does any1 has a successful 
example of having 2 sco channel open (to different devices) at the same 
time?

Regards,
   Victor.
 -- 



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
