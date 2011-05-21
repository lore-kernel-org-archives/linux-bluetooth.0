Return-Path: <cyrus@holtmann.org>
Message-ID: <0EE436F9EA9C4AA183F5FCCA911FBB60@freqoneremote>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "Siva kumar" <sivakumar@ethicstech.in>,
	"Bartosz Szatkowski" <bulislaw@linux.com>
Cc: <linux-bluetooth@vger.kernel.org>
References: <4DD675D5.1030601@ethicstech.in> <BANLkTimFfLJxwyTM2MNcVeEMC2n+r2MsHA@mail.gmail.com> <4DD75480.3030509@ethicstech.in>
In-Reply-To: <4DD75480.3030509@ethicstech.in>
Subject: Re: How to test ssp pairing in linux
Date: Sat, 21 May 2011 11:41:29 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=response
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Siva (and Bartosz),

Bartosz Szatkowski wrote:
> On Fri, May 20, 2011 at 4:08 PM, Siva kumar <sivakumar@ethicstech.in> 
> wrote:
>
>> Hi all,
>>
>>           I had an android mobile with ssp pairing ssp pairing support, i
>> want to check ssp pairing. When i try to pair with pc it asks for pin. i
>> don't known how to enable ssp pairing in pc, i am using ubuntu 9.10
>>
>> Regards
>> sivakumar
>> --
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-bluetooth"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>
> Hi,
> what is Your BlueZ version? Also on some (older) Android devices
> (ROMs) there is no SSP, (not sure whether agent version matters eg
> bluetooth-applet).
> In other cases SSP should be used by default.
>
>

+++++

I am running BlueZ 4.93, and have noticed when attempting to connect, BlueZ 
connects and closes the connection the first time.

plugins/hciops.c:conn_complete() status 0x00
src/adapter.c:adapter_get_device() <dev addr>
plugins/hciops.c:remote_features_information() hci0 status 0
plugins/hciops.c:disconn_complete() handle 38 status 0x00
src/event.c:btd_event_disconn_complete()
src/adapter.c:adapter_remove_connection()


Fortunately for me, I control my device's firmware, and instead of giving 
up, just retry the connection a few seconds later (using the CSR stack).

plugins/hciops.c:conn_complete() status 0x00
src/adapter.c:adapter_get_device() <dev addr>
plugins/hciops.c:remote_features_information() hci0 status 0
plugins/hciops.c:io_capa_response() hci0 IO capability response from <dev 
addr>
plugins/hciops.c:io_capa_request() hci0 IO capability request for <dev addr>
plugins/hciops.c:get_auth_info() hci0 dba <dev addr>
plugins/hciops.c:get_io_cap() initial authentication requirement is 0x04
plugins/hciops.c:get_io_cap() final authentication requirement is 0x04
plugins/hciops.c:user_confirm_request() hci0
plugins/hciops.c:user_confirm_request() auto accept of confirmation
plugins/hciops.c:hciops_confirm_reply() hci0 dba <dev addr> success 1
plugins/hciops.c:simple_pairing_complete() hci0 status 0
src/event.c:btd_event_simple_pairing_complete() status=00

In my device the HCI code returned is 19 (0x13: Remote User Terminated 
Connection)

Also, note that when connecting with my BlackBerry Torch and my Windows XP, 
Windows 7 and Windows 2008r2 laptops (all using the Toshiba stack), this 
disconnection does not happen.  Pairing works just fine, albeit Legacy 
pairing (requiring PIN entry at the laptop).

Hope this helps.

FWIW: Bluez/Dev box is Fedora14, AMD x86 Sempron, running hand-built BlueZ 
4.93 (none of the stuff from the Fed14 package).  USB Class 1 BT 2.1 Dongle 
from Cirago, but based on CSR BC04 chip.

David Stockwell
Frequency One

+++++


I am using bluez 4.51-Oubuntu2, i have conformed my android phone has
ssp as i was able to connect with other android device using ssp pairing.
When i connect with the desktop it asks for pin.



--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" 
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html 

