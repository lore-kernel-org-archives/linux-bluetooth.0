Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] BT unter SuSE 9.2
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAPFR022I+ek2ATkOW7ZKVBgEAAAAA@t-online.de>
References: 
	 <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAPFR022I+ek2ATkOW7ZKVBgEAAAAA@t-online.de>
Content-Type: text/plain
Message-Id: <1102599865.9988.210.camel@pegasus>
Mime-Version: 1.0
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
Date: Thu, 09 Dec 2004 14:44:25 +0100

Hi Peter,

> ##>maybe you simply have to run YaST once and activate Bluetooth.
> 
> In the meantime, I'm able to establish a connection to teh Bluetooth-Modul.
> I solved the problem by the boot-command pci=noapci

to what? Either it is "noapic" or "noacpi".

> after this I was able to start dmabt and now, the bluetooth-function of my
> notebook is identified by kbluetoothd! What is to be done in order to start
> dmabt automatically on the right time?

Do you configured it with YaST? Otherwise the deamons might not start
and don't forget to set your PIN.

> ##>
> ##>> At the moment I'm working with Windows, also connected by the 
> ##>> BT-device to my network.
> 
> But, when I try to find the use the LAN-Service of the BT-Accesspoint I get
> get teh message
> Authorization failure
> 
> The BT-accesspoint is asking for a PIN and I think it's acting as a master.
> So I'm not able to send the right PIN. I changed in hcid.conf the PIN-asking
> from auto to none and user, witout any success. The BT-accesspoint requires
> a PIN, it is not possible to set this routine out of function.

Don't touch it. Check with "hcidump -X" what is going on.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
