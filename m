Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 Jan 2012 16:19:46 +0200
From: Johan Hedberg <johan.hedberg@intel.com>
To: "Aj, SanthoshX" <santhoshx.aj@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Holtmann, Marcel" <marcel.holtmann@intel.com>,
	"Nair, Rashmi G" <rashmi.g.nair@intel.com>
Subject: Re: [PATCH] Breaks in A2DP playback during device search
Message-ID: <20120105141946.GA8667@x220>
References: <001F63875E1AF5428162B5A2D3ED1BDD8E98@IRSMSX101.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <001F63875E1AF5428162B5A2D3ED1BDD8E98@IRSMSX101.ger.corp.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jan 05, 2012, Aj, SanthoshX wrote:
> From 8ecb4074305613a113d1c8dd220ab856c5f7ebc1 Mon Sep 17 00:00:00 2001
> From: Santhosh <santhoshx.aj@intel.com>
> Date: Wed, 4 Jan 2012 12:44:37 +0530
> Subject: [PATCH] To change the latency of controller
>  This change is done to fix the a2dp breaks as the IMC controller
>  expects the latency to be set explicitly by calling HCI QoS setup
> 
> ---
>  audio/device.c         |    7 +++
>  common/Android.mk      |    3 +-
>  common/android_bluez.c |  111 ++++++++++++++++++++++++++++++++++++++---------
>  3 files changed, 98 insertions(+), 23 deletions(-)

As was previously mentioned by others patches to this list are expected
to be against the upstream git tree. This looks like something else. One
thing I'd like to add though:

> +static int vendor_high_priority(int fd, uint16_t handle) {
> +    unsigned char hci_sleep_cmd[] = {
> +        0x01,               // HCI command packet
> +        0x57, 0xfc,         // HCI_Write_High_Priority_Connection
> +        0x02,               // Length
> +        0x00, 0x00          // Handle
> +    };
> +
> +    hci_sleep_cmd[4] = (uint8_t)handle;
> +    hci_sleep_cmd[5] = (uint8_t)(handle >> 8);
> +
> +    int ret = write(fd, hci_sleep_cmd, sizeof(hci_sleep_cmd));
> +    if (ret < 0) {
> +        error("write(): %s (%d)]", strerror(errno), errno);
> +        return -1;
> +    } else if (ret != sizeof(hci_sleep_cmd)) {
> +        error("write(): unexpected length %d", ret);
> +        return -1;
> +    }
> +    return 0;
> +}

When you need to need to create a mechanism which controls some aspect
of an RFCOMM, L2CAP or ACL link your first option should be to consider
implementing it as a socket option. If that's not possible (though in
this case I think it is) then the only other alternative is to abstract
it behind the adapter_ops interface since the core daemon shouldn't any
longer do direct HCI access. So you'd implement sending this command in
hciops and then add the appropriate mgmt command and add support for it
into mgmtops.c and the kernel.

Johan
