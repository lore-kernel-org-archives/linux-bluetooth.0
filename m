Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Ruben Jenster <rjenster@web.de>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200503301323.56682.rjenster@web.de>
Subject: [Bluez-devel] Connect button does not work anymore?
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
Date: Wed, 30 Mar 2005 13:23:56 +0000

Hi,

connecting to my headset works with btsco v0.4 but the connect/disconnect 
button does not work anymore. When starting btsco in verbose mode I get 
displayed when the button was pressed but nothing happens.
Is this a wanted behaviour?

tsco v0.4
Device is 0:0
Voice setting: 0x0060
RFCOMM channel 1 connected
speaker volume: 1 mic volume: 1
driver is in use
connected SCO channel
Done setting sco fd
recieved AT+VGS=01
Sending up speaker change 1
speaker volume: 1 mic volume: 1
driver is not in use
disconnected SCO channel
speaker volume: 1 mic volume: 1
driver is in use
connected SCO channel
Done setting sco fd
recieved AT+VGS=01
Sending up speaker change 1
recieved AT+CKPD=200		-> connect button pressed


Regards 

Ruben


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
