Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4247F63F.70206@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] getting bluetooth v1.2
References: <25911.1111942263@www59.gmx.net>	 <1111943294.9195.250.camel@pegasus>  <4247EEE0.8010002@gmx.ch> <1112011490.9016.27.camel@pegasus>
In-Reply-To: <1112011490.9016.27.camel@pegasus>
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
Date: Mon, 28 Mar 2005 14:19:11 +0200

Hello Marcel

Marcel Holtmann wrote:
> Hi Marco,
> 
> 
>>>The CSR BlueCore02/BlueCore3/BlueCore4 chips support inquiry with RSSI,
>>>but the Silicon Wave ROM chips I have seen so far have a problem with
>>>inquiry with RSSI event size. The Broadcom chips don't support inquiry
>>>with RSSI (this includes the Microsoft 2.0 dongle).
>>
>>hciconfig -a tells me that the manufacturer of my dongle is "Cambridge 
>>Silicon Radio (10)". this is one of the problems-dongle, right?
> 
> 
> check with "hciconfig hci0 revision" as root what BlueCore chip is on it
> and no, these are not the problematic dongles.

it's a BlueCore02

>>so, an update to bt v1.2 wouldn't make sense to me...
> 
> What does "lsusb" tells you?

it think you mean this line:
Bus 002 Device 008: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle


>>>>Is it still to early for bluetooth v1.2?
>>>
>>> 
>>>It is actually too late, because we are moving to Bluetooth 2.0 with EDR
>>>support.
>>
>>but it's too early for 2.0 yet?
> 
> 
> Actually it is not. The only problem at the moment is that the Bluetooth
> module manufactures don't get the BlueCore4 modules done. After that you
> will see them in the USB dongles and the CSR BlueCore4 already supports
> EDR without any problems and so do BlueZ.

regards
Marco


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
