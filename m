Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH] tools/btattach: Add detach option
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAL9uMOEQyo3RmyOEs_7eM0FsRSktB+=5Jw6HCOV4Gvw6Wn66bg@mail.gmail.com>
Date: Thu, 2 Feb 2017 11:28:29 +0100
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Carlo Caione <carlo@caione.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Message-Id: <1626001B-33D7-4B19-8798-8C18D6DADF6B@holtmann.org>
References: <20170201171431.9633-1-carlo@caione.org>
 <D130D4FB-7AF0-46BF-9BC7-D9050C596E1A@holtmann.org>
 <CAL9uMOEvFH-mi23U_9SYDcQ7oXJQMB5cy4TL0VKp6OL7Si1ePg@mail.gmail.com>
 <02A0165B-9058-4663-9809-E7DA030E0878@holtmann.org>
 <CAL9uMOEQyo3RmyOEs_7eM0FsRSktB+=5Jw6HCOV4Gvw6Wn66bg@mail.gmail.com>
To: Carlo Caione <carlo@endlessm.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Carlo,

> >>> ---
> >>> tools/btattach.c | 10 +++++++++-
> >>> 1 file changed, 9 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/tools/btattach.c b/tools/btattach.c
> >>> index 5adbc8d..f1f115d 100644
> >>> --- a/tools/btattach.c
> >>> +++ b/tools/btattach.c
> >>> @@ -194,6 +194,7 @@ static void usage(void)
> >>>              "\t-P, --protocol <proto> Specify protocol type\n"
> >>>              "\t-S, --speed <baudrate> Specify which baudrate to use\n"
> >>>              "\t-N, --noflowctl        Disable flow control\n"
> >>> +             "\t-D, --detach           Open device and then fork\n"
> >>>              "\t-h, --help             Show help options\n”);
> >>
> >> And is this really a good idea. I think that I had removed all the fork calls from the standard tools. Mainly since we fail to maintain the signals and more important child signals correctly. So we quickly end up with zombies or orphaned processes. My thinking instead was to leave this to systemd to handle.
> >
> > Interesting. Any pointer how to achieve that?
> > The problem is that I have btattach called by a systemd unit file to
> > download the firmware to the bluetooth transceiver. I also have
> > another systemd unit that must be called strictly after btattach has
> > done uploading the firmware. Since btattach is hanging on the port
> > AFAIU there is no way I can tell exactly when it is done uploading the
> > firmware. That's why I was adding this detach option, to mark the unit
> > as 'Type=forking' and enforcing the ordering with
> > 'Before=next.service`.
> > Anything I am missing?
> 
> why do you need to know when the firmware uploading has completed? What hardware is this?
> 
> The hardware is a custom ARM board based on an Amlogic SOC.
> More specifically I need btattach systemd unit to run before systemd-rfkill. This is because the rfkill driver is actually driving the GPIO enable of the transceiver, so if systemd-rfkill runs before btattach has completed telling to disable the radio (because we rebooted with the BT off) this just interrupts the firmware downloading leaving the transceiver in a non-working state.

this whole design mess with RFKILL switches for GPIO reset lines is a problem. We start fixing this for Intel and Broadcom based Bluetooth chips. So I would prefer if we can get this fixed inside the kernel. Also serdev bus is coming that will make btattach obsolete for hardwired Bluetooth UART chips.

And frankly, I would prefer to add RFKILL handling to btattach then trying to introduce a fork() which only existence to is to do some syncing with systemd-rfkill.

Regards

Marcel

