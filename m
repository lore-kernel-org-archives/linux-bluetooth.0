Return-Path: <bluez-users-admin@lists.sourceforge.net>
In-Reply-To: <1077725935.2919.116.camel@pegasus>
References: <opr3xmdugiqdj9uv@mail.gmx.de> <1077725935.2919.116.camel@pegasus>
Subject: Re: [Bluez-users] Bluetooth Access Point elmeg D@VOS-44.dsl
To: Bluez-users@lists.sourceforge.net
Message-ID: <opr3xt45o6qdj9uv@mail.gmx.de>
From: Florian <Kimpenhaus@gmx.de>
Content-Type: text/plain; format=flowed; charset=iso-8859-1
MIME-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 25 Feb 2004 19:11:19 +0100

On Wed, 25 Feb 2004 17:18:55 +0100, Marcel Holtmann <marcel@holtmann.org> 
wrote:

> Hi Florian,
>
>> im using an elmeg D@VOS-44.dsl AP has anyone figured out how to pair and
>> connect the device
>> or is it impossible too do that using bluez(at the moment)?
>
> it looks like the AP is using LAN access using PPP and DUN. So it should
> be easy to connect to the AP using
>
> 	dund --connect <bdaddr-ap>
>
> Please also run "hcitool info <bdaddr-ap>" (as root) and show us the
> output.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> SF.Net is sponsored by: Speed Start Your Linux Apps Now.
> Build and deploy apps & Web services for Linux with
> a free DVD software kit from IBM. Click Now!
> http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

hi again,

thx for the high speed reply,

i have run both
bash-2.05b# dund --connect 00:0B:CE:00:01:8E

bash-2.05b# hcitool info 00:0B:CE:00:01:8E
Requesting information ...
          BD Address:  00:0B:CE:00:01:8E
          Device Name: elmeg D@VOS-44.dsl
          LMP Version: 1.1 (0x1) LMP Subversion: 0x175
          Manufacturer: Cambridge Silicon Radio (10)
          Features: 0xff 0xff 0x0f 0x00
                  <3-slot packets> <5-slot packets> <encryption> <slot 
offset>
                  <timing accuracy> <role switch> <hold mode> <sniff mode>
                  <park mode> <RSSI> <channel quality> <SCO link>
                  <HV2 packets> <HV3 packets> <u-law log> <A-law log>
                  <CVSD> <paging scheme> <power control> <transparent SCO>

mhh this is what i get. But still no clue how to get things working.
In my eyes pairing comes next then establishing a connetion and then tell 
the AP
username and passwd.
Found an option in dund using MSDUN but did not get it the way i want.

suggestions?

Regards

Florian

P.S.: tried using  mailing list archives 
(http://sourceforge.net/mailarchive/forum.php?forum_id=672)
but get
ERROR
Forum not found

-- 
Using M2, Opera's revolutionary e-mail client: http://www.opera.com/m2/


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
