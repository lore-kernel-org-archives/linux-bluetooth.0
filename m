Return-Path: <cyrus@holtmann.org>
Message-ID: <1327163453.1955.43.camel@aeonflux>
Subject: Re: [RFC PATCH 1/3] lib: add header of device class constants
From: Marcel Holtmann <marcel@holtmann.org>
To: Scott James Remnant <scott@netsplit.com>
Cc: linux-bluetooth@vger.kernel.org, keybuk@chromium.org
Date: Sat, 21 Jan 2012 17:30:53 +0100
In-Reply-To: <1327100744-28782-2-git-send-email-scott@netsplit.com>
References: <1327100744-28782-1-git-send-email-scott@netsplit.com>
	 <1327100744-28782-2-git-send-email-scott@netsplit.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

>  Makefile.am  |    2 +-
>  lib/bt_ids.h |  133 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 134 insertions(+), 1 deletions(-)
>  create mode 100644 lib/bt_ids.h
> 
> diff --git a/Makefile.am b/Makefile.am
> index 102ee62..8dbe603 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -59,7 +59,7 @@ plugin_LTLIBRARIES =
>  
>  lib_headers = lib/bluetooth.h lib/hci.h lib/hci_lib.h lib/mgmt.h \
>  		lib/sco.h lib/l2cap.h lib/sdp.h lib/sdp_lib.h lib/uuid.h \
> -		lib/rfcomm.h lib/bnep.h lib/cmtp.h lib/hidp.h
> +		lib/rfcomm.h lib/bnep.h lib/cmtp.h lib/hidp.h lib/bt_ids.h
>  local_headers = $(foreach file,$(lib_headers), lib/bluetooth/$(notdir $(file)))

I rather not make this part of the library. We are actually trying to
shrink the library and not keep extending it. So put this file locally
in src/ where you use it.

> +
> +#ifndef __BT_IDS_H
> +#define __BT_IDS_H

Once it is local, please no circular inclusion protection. I wanna have
it fail badly if anybody things circular inclusion are acceptable.

> +
> +/* Service classes */
> +#define BLUETOOTH_SERVICE_CLASS_BITMASK                 0xFFE000
> +#define BLUETOOTH_SERVICE_CLASS_LIMITED_DISCOVERABILITY 0x002000
> +#define BLUETOOTH_SERVICE_CLASS_POSITIONING             0x010000
> +#define BLUETOOTH_SERVICE_CLASS_NETWORKING              0x020000
> +#define BLUETOOTH_SERVICE_CLASS_RENDER                  0x040000
> +#define BLUETOOTH_SERVICE_CLASS_CAPTURE                 0x080000
> +#define BLUETOOTH_SERVICE_CLASS_OBJECT_TRANSFER         0x100000
> +#define BLUETOOTH_SERVICE_CLASS_AUDIO                   0x200000
> +#define BLUETOOTH_SERVICE_CLASS_TELEPHONE               0x400000
> +#define BLUETOOTH_SERVICE_CLASS_INFORMATION             0x800000
> +
> +#define BLUETOOTH_SERVICE_CLASS(_class) \
> +                                ((_class) & BLUETOOTH_SERVICE_CLASS_BITMASK)

You might wanna think about shortening this a bit. Something like
BT_SVC_CLASS or similar.

Regards

Marcel


