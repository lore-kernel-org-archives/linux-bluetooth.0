Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140125221329.GB14531@x220.p-661hnu-f1>
References: <20140125005506.7AD85100900@puck.mtv.corp.google.com>
	<20140125221329.GB14531@x220.p-661hnu-f1>
Date: Sun, 26 Jan 2014 20:07:50 -0800
Message-ID: <CAGXr9JHEe+9gu-giUF=iH4LAv=FAAutYPeFY483DQU2r40wmkg@mail.gmail.com>
Subject: Re: [PATCH] Rename adapter_remove_device to btd_adapter_remove_device
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	johan.hedberg@gmail.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

I would need this for the IR-assist device discovery plugin that I'm
writing. Basically, I have a HID remote control which is not
discoverable (but it is connectable). When this HID remote is in
unpaired state, it sends its BD address to the host via IR. The plugin
will get the BD address and do the following:

device = btd_adapter_find_device(adapter, &device_bdaddr);
if (device) {
    /* remove old pairing and device info */
    btd_device_set_temporary(device, TRUE);
    btd_adapter_remove_device(adapter, device);
}

/* (re)create the device */
device = btd_adapter_get_device(adapter, &device_bdaddr, BDADDR_BREDR);
btd_device_device_set_name(device, ...);
btd_device_set_pnpid(device, ...);
btd_device_set_temporary(device, FALSE);

-- Petri

On Sat, Jan 25, 2014 at 2:13 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Petri,
>
> On Fri, Jan 24, 2014, Petri Gynther wrote:
>> Allow this symbol to be exported and usable from external plugins.
>> ---
>>  src/adapter.c | 14 +++++++-------
>>  src/adapter.h |  3 +++
>>  2 files changed, 10 insertions(+), 7 deletions(-)
>
> The patch looks fine, but we usually don't export symbols without
> knowing that there exists a valid use case for it. So could you perhaps
> give some background (or even a follow-up patch) to explain what you
> need this for?
>
> Johan
