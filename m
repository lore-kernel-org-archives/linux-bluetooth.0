Return-Path: <jikos@kernel.org>
Date: Tue, 21 Nov 2017 11:18:07 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
cc: Marcel Holtmann <marcel@holtmann.org>, Niels Skou Olsen <nolsen@jabra.com>,
    linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
    linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Quirks cleanup and hid-generic niceness
In-Reply-To: <20171120104844.31977-1-benjamin.tissoires@redhat.com>
Message-ID: <nycvar.YFH.7.76.1711211117070.11505@cbobk.fhfr.pm>
References: <20171120104844.31977-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 20 Nov 2017, Benjamin Tissoires wrote:

> Hi,
> 
> this is v3 rebased on top of for-next.
> There are no other changes.
> 
> Cheers,
> Benjamin
> 
> Benjamin Tissoires (4):
>   HID: core: move the dynamic quirks handling in core
>   HID: quirks: move the list of special devices into a quirk
>   HID: core: move the list of ignored devices in hid-quirks.c
>   HID: core: remove the absolute need of hid_have_special_driver[]
> 
>  drivers/hid/Makefile            |    2 +-
>  drivers/hid/hid-core.c          |  932 ++---------------------------
>  drivers/hid/hid-generic.c       |   68 ++-
>  drivers/hid/hid-quirks.c        | 1248 +++++++++++++++++++++++++++++++++++++++
>  drivers/hid/usbhid/Makefile     |    2 +-
>  drivers/hid/usbhid/hid-core.c   |   10 +-
>  drivers/hid/usbhid/hid-quirks.c |  402 -------------
>  include/linux/hid.h             |   21 +-
>  net/bluetooth/hidp/core.c       |    2 +-
>  9 files changed, 1395 insertions(+), 1292 deletions(-)
>  create mode 100644 drivers/hid/hid-quirks.c
>  delete mode 100644 drivers/hid/usbhid/hid-quirks.c

Applied to for-4.16/hid-quirks-cleanup-base (not pushed into for-next yet 
though, as 4.15 merge window is still open).

Thanks,

-- 
Jiri Kosina
SUSE Labs
