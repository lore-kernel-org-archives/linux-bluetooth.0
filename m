Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Sebastian Roth <sebastian.roth@esk.fhg.de>
Message-ID: <cp3mkk$m7t$1@sea.gmane.org>
References: <20041206225609.GA1177@zeus.galaxy.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
In-Reply-To: <20041206225609.GA1177@zeus.galaxy.org.uk>
Subject: [Bluez-devel] Re: snd-bt-sco problem
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
Date: Tue, 07 Dec 2004 08:37:56 +0100

Hi Chris,

I'm new to this bluetooth things so please don't mind if my suggestions 
are not completely correct.

I've had some problems with my bluetooth headsets too.
The first problem was the dongle. I've used an usb-dongle from Anycom 
(Transilica chip). Exchanging the dongle with a D-Link DBT-120 
(Cambridge Silicon Radio chip) helped me because this chip routes the 
SCO data over HCI.
Please post the ouput of `hciconfig hci0 revision'

The second issue was that all "sound-apps" were blocking (hanging) 
without playing any sound. My headsets (both from Anycom) must be 
activated with the switch to recieve the sound. Just like answer the 
telephone.

Everone, please feel free to correct me if I'm wrong!

Best regards,
Sebastian



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
