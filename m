Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1335004527.16897.337.camel@aeonflux>
References: <CAB7rCTjRzTZP6TDgsrWvFxE8zuFuYDBQdMnjyvnM4p6Cw=ro2g@mail.gmail.com>
	<1335004527.16897.337.camel@aeonflux>
Date: Sat, 21 Apr 2012 12:06:35 -0500
Message-ID: <CAB7rCTiu18D8h611avpWqP9fD2STaWMErN7bSv-af-7yvraQaw@mail.gmail.com>
Subject: Re: PTS / linkkey issue
From: Mike <puffy.taco@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Apr 21, 2012 at 5:35 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Mike,
>
>> I'm having a somewhat relate issue to Vishal AGARWAL [1]. =A0The trouble
>> I have is that the PTS system is requesting auth type 0, and Bluez
>> happily obliges. =A0This leaves the PTS device as temporary, and BlueZ
>> then deletes this device after the end of the connection. =A0This
>> prevents me from being able to pass TP/OOR/BV-02-I: [HF reconnects to
>> AG]. =A0The code is designed to periodically reconnect to the AG after
>> it detects a link timeout. =A0But, if BlueZ has deleted the device, I
>> don't do that. =A0This also somewhat applies to the A2DP test cases, as
>> my device must be left in pairing mode in order for the tests to pass.
>>
>> So, my question to people who have used PTS, is there a way to get the
>> PTS to perform a pairing that is not 0x00 MITM Protection Not Required
>> =96 No Bonding. Numeric comparison with automatic accept allowed? =A0I'm
>> using an older kernel that doesn't have the mgmt interface (2.6.33
>> with some features/fixes backported from newer kernels) but am using
>> the latest BlueZ from git (at least of a month ago or so). =A0But even
>> so, the proposal of keeping the linkkey around for the ACL session
>> would be useless, I think, because the intent is to have a link
>> timeout event.
>
> can you quickly check if for some weird reason the PTS uses debug keys
> or if you enabled debug keys within BlueZ.
>
> We treat debug keys even worse than no bonding. Unless you set DebugKeys
> in /etc/bluetooth/main.conf they are thrown out right away. However be
> really careful here. That option is only for debugging. You should never
> ever leave that on in a production device. You would make your device
> vulnerable like no tomorrow.
>
> Regards
>
> Marcel
>
>

I checked hci dumps of both the init of my unit and the trace from the
PTS run, and neither had sent the HCI_Write_Simple_Pairing_Debug_mode
command.  Plus we can see that the key type is 0x04, Unauthenticated
Combination Key.  I also verified that DebugKeys was false in
main.conf.

Thanks,
Mike
