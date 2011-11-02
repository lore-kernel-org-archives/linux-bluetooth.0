Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/4] Bluetooth: prioritizing data over HCI
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 02 Nov 2011 15:22:31 +0100
In-Reply-To: <1320241924-2300-1-git-send-email-luiz.dentz@gmail.com>
References: <1320241924-2300-1-git-send-email-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1320243753.15441.282.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> This implement priority based scheduler using skbuffer priority set via
> SO_PRIORITY socket option.
> 
> It introduces hci_chan_hash (list of HCI Channel/hci_chan) per connection,
> each item in this list refer to a L2CAP connection and it is used to
> queue the data for transmission.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |   43 +++++++++++-
>  include/net/bluetooth/l2cap.h    |    1 +
>  net/bluetooth/hci_conn.c         |   53 ++++++++++++++
>  net/bluetooth/hci_core.c         |  143 ++++++++++++++++++++++++++++++++------
>  net/bluetooth/l2cap_core.c       |   63 +++++++++--------
>  net/bluetooth/smp.c              |    3 +-
>  6 files changed, 251 insertions(+), 55 deletions(-)

I looked through all 4 patches and it seems fine to me. Lets get this
merged and take it for a spin.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


