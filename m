Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_MtG=Ar8N836PK11LeiSqs8K7foCfbm=qeCF39rmj=whg@mail.gmail.com>
References: <CANq1E4TMGGwiz-kGGCqGOn+A-D-msiTAb8L4Yf6kkMwrzOnn_g@mail.gmail.com>
	<CAJdJm_MtG=Ar8N836PK11LeiSqs8K7foCfbm=qeCF39rmj=whg@mail.gmail.com>
Date: Tue, 19 Mar 2013 14:06:35 +0100
Message-ID: <CANq1E4SZR+uzMhuFOYB+XbzbONPhv_jeiH53GByq+_nF+pCZKg@mail.gmail.com>
Subject: Re: Device selection during inquiry
From: David Herrmann <dh.herrmann@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

On Tue, Mar 19, 2013 at 12:02 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi David,
>
> On Mon, Mar 18, 2013 at 8:07 PM, David Herrmann <dh.herrmann@gmail.com> wrote:
>> A Bluetooth Host searches for target devices via standard inquiry (at
>> least I think so). The devices can be placed into discoverable mode
>> for 20s via a "sync" button. Once they are found, a baseband
>> connection is created by the host and the devices are paired via a
>> simple BT-address related PIN.
>>
>> I can easily replace the host with a BlueZ host and connect to the
>> devices via a normal inquiry and then open the baseband connection.
>> However, I haven't succeeded in replacing the target devices with a
>> BlueZ host. I simply cannot trick the proprietary host into connecting
>> to my device. In fact, "hcidump" doesn't give me anything while the
>> host is performing the inquiry. I couldn't even figure out the
>> BT-address of the host.
>
> I remembered that I used to change BlueZ's default LAP (0x9e8b33,
> which is the GIAC) and use that same value on the "host" side in order
> to filter out unwanted devices during inquiry. This allowed me to get
> "cleaner" hcidumps because I could only "see" the devices which are
> using IACs generated from that same LAP. See page 315 of the Core V4.0
> spec for some intro to these concepts.
>
> It's possible that the Wii Remote uses a different LAP than of that of
> BlueZ's, and that the Wii host runs inquiry using that LAP in order to
> reduce the list of found devices and improve discovery latency. BlueZ
> sees all devices because it uses the GIAC.
>
> If that's the case, you need to find out this LAP and use the same
> value. But It might be just that simple because other controller
> parameters are also used to calculate the IAC. Unfortunately, I know
> very little about this part of the spec (I only play with it for
> testing). But I hope it helps you looking for further info.

Yeah, that was it. The remotes are set to LIAC mode and it turns out
that the host performs an LIAC inquiry exclusively.

And for the archive:
I changed my local adapter mode via "hciconfig hci0 iac liac" to liac mode.

Thanks for the hint!
David
