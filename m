Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] problem with hstest
From: Marcel Holtmann <marcel@holtmann.org>
To: Mr Jie Liu <s4048156@student.uq.edu.au>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20561a20c28e.20c28e20561a@uq.edu.au>
References: <20561a20c28e.20c28e20561a@uq.edu.au>
Content-Type: text/plain
Message-Id: <1084873159.5833.75.camel@pegasus>
Mime-Version: 1.0
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
Date: Tue, 18 May 2004 11:39:19 +0200

Hi,

> I try to play sound through my HBH-35 headset. I am using the hstest program of the bluez package to test the headset profile. But I can't hear anything through the headset. The voice setting is right(0x0060). I can establish rfcomm and soc link with the headset and the AT command seems to work fine because I can hear the RING tone. When I push the button on the headset, the AT command could also be printed out correctly. I use "hstest recor
> d sound X:X:X:X:X:X X" to record a file. Then I try to replay it by "hstest play sound X:X:X:X:X:X X". But there is nothing from the headset and the program also has no error message. Has anyone experienced this before? What kind of information should I provide to analyse it? 

check if the SCO data is routed through the HCI or through the PCM
interface of your Bluetooth dongle. If your dongle is CSR based, this
can be done with "hciconfig hci0 revision".

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
