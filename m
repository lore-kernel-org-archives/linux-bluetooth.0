Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120718070412.GB18697@aemeltch-MOBL1>
References: <CADX0rsZBLixOvNLhpoSH6PuP3m8LWP6w6CkDKB+cvhBAnwyT0g@mail.gmail.com>
	<20120717180556.GB19582@joana>
	<CADX0rsbXe8Sv8cu_Q_3BYLWCC=N3TCQdKVCC1Tay_gSfrAQWpQ@mail.gmail.com>
	<20120718070412.GB18697@aemeltch-MOBL1>
Date: Wed, 18 Jul 2012 15:39:28 +0800
Message-ID: <CADX0rsZAV=c0Pj456RWUEKj+4XRuk=cv44aYuxUW1WMvvpuZxg@mail.gmail.com>
Subject: Re: HCI Remote Name Request error "Page Timeout"
From: victor yeo <victoryeo1974@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	victor yeo <victoryeo1974@gmail.com>,
	Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jul 18, 2012 at 3:04 PM, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
> Hi Victor,
>
> On Wed, Jul 18, 2012 at 02:26:47PM +0800, victor yeo wrote:
>> > Hi Victor,
>> >
>> > * victor yeo <victoryeo1974@gmail.com> [2012-07-17 17:34:32 +0800]:
>> >
>> >> Hi,
>> >>
>> >> The hcidump program shows a remote name request "Page Timeout" error.
>> >> I do not understand the reason. The Bluez stack requests for remote
>> >> name, the device replied with 'Nonin_Medical_Inc._359443' twice, Then
>> >> Bluez stack requests again, got "Page Timeout" error, and connection
>> >> stops. What is the reason of this behavior?
>> >>
>> >> Thanks,
>> >> Victor
>> >>
>> >> < HCI Command: Remote Name Request (0x01|0x0019) plen 10
>> >>     bdaddr 00:1C:05:00:70:44 mode 2 clkoffset 0x0000
>> >> > HCI Event: Command Status (0x0f) plen 4
>> >>     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
>> >> > HCI Event: Remote Name Req Complete (0x07) plen 255
>> >>     status 0x00 bdaddr 00:1C:05:00:70:44 name 'Nonin_Medical_Inc._359443'
>> >> < HCI Command: Remote Name Request (0x01|0x0019) plen 10
>> >>     bdaddr 00:1C:05:00:70:44 mode 2 clkoffset 0x0000
>> >> > HCI Event: Command Status (0x0f) plen 4
>> >>     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
>> >> > HCI Event: Remote Name Req Complete (0x07) plen 255
>> >>     status 0x00 bdaddr 00:1C:05:00:70:44 name 'Nonin_Medical_Inc._359443'
>> >> < HCI Command: Remote Name Request (0x01|0x0019) plen 10
>> >>     bdaddr 00:1C:05:00:70:44 mode 2 clkoffset 0x0000
>> >> > HCI Event: Command Status (0x0f) plen 4
>> >>     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
>> >> > HCI Event: Remote Name Req Complete (0x07) plen 255
>> >>     status 0x04 bdaddr 00:1C:05:00:70:44 name ''
>> >>     Error: Page Timeout
>
> BTW: What about adding timestamp, just wondering are those requests sent
> immediately one after one.
>
>> > Can you enable dynamic_debug on your kernel for the bluetooth module and post
>> > those logs to us? I wanna see what HCI is doing here.
>> >
>> >         Gustavo
>>
>> So i re-build the kernel with CONFIG_DYNAMIC_DEBUG, use the newly
>> built kernel, then run?
>>
>> echo -n 'module bluetoothd +p' >    <debugfs>/dynamic_debug/control
>
> something like this is enough:
>
>         echo 'file l2cap_core.c +fpt' > /debugfs/dynamic_debug/control; \
>         echo 'file hci_conn.c +fpt' > /debugfs/dynamic_debug/control; \
>         echo 'file hci_event.c +fpt' > /debugfs/dynamic_debug/control; \
>         echo 'file hci_core.c +fpt' > /debugfs/dynamic_debug/control"
>
> Best regards
> Andrei Emeltchenko
>

Hi,


I found out the root cause of the "Page Timeout" error. I swap in
another bluetooth module. The device data is received by Bluez.
