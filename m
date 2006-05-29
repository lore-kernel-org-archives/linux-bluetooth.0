Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <BAY111-DAV9ED2F199701CD22A20DCC98A00@phx.gbl>
References: <BAY111-DAV9ED2F199701CD22A20DCC98A00@phx.gbl>
Date: Mon, 29 May 2006 15:29:12 +0200
Message-Id: <1148909352.31689.55.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] request for a code ?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Oezkan,

> 
> i need a code which its report signal strength of discovered devices. 
> 
> thank a lot , 
>  
> PS: my bluetooth dongle epox BT-DG03 is compliant with spec. v1.1 but
> when i do : 
>         ~$ hciconfig hci0 features
>         hci0:   
>              Type: USB        
>                  BD Address: 00:04:61:81:B8:45 ACL MTU: 192:8 SCO MTU:
>         64:8
>                  Features: 0xff 0xff 0x0b 0x00 0x00 0x00 0x00
>         0x00              
>                  <3-slot packets> <5-slot packets> <encryption> <slot
>         offset>             
>                  <timing accuracy> <role switch> <hold mode> <sniff
>         mode>                
>                  <park state> <RSSI> <channel quality> <SCO link> <HV2
>         packets>                
>                  <HV3 packets> <u-law log> <A-law log> <CVSD> <paging
>         scheme>              
>                  <transparent SCO>
>         i see here RSSI so thats mean can i take this signal strenght
>         report ? 

all Bluetooth 1.1 devices can only report the RSSI value for already
connected devices and even this doesn't return a good value all the
time. Some old dongles are rather buggy in this area.

However if you look for the RSSI value returned from the inquiry results
you need at least a Bluetooth 1.2 dongle that support "Inquiry with
RSSI".

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
