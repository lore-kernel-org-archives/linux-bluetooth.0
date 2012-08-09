Return-Path: <cyrus@holtmann.org>
Message-ID: <1344527652.2083.56.camel@aeonflux>
Subject: Re: [RFC v4 3/3] Bluetooth: mgmt: Add device disconnect reason
From: Marcel Holtmann <marcel@holtmann.org>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Date: Thu, 09 Aug 2012 08:54:12 -0700
In-Reply-To: <1344498750-2698-4-git-send-email-mikel.astiz.oss@gmail.com>
References: <1344498750-2698-1-git-send-email-mikel.astiz.oss@gmail.com>
	 <1344498750-2698-4-git-send-email-mikel.astiz.oss@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

> MGMT_EV_DEVICE_DISCONNECTED will now expose the disconnection reason to
> userland, distinguishing four possible values:
> 
> 	0x00	Reason not known or unspecified
> 	0x01	Connection timeout
> 	0x02	Connection terminated by local host
> 	0x03	Connection terminated by remote host
> 
> Note that the local/remote distinction just determines which side
> terminated the low-level connection, regardless of the disconnection of
> the higher-level profiles.
> 
> This can sometimes be misleading and thus must be used with care. For
> example, some hardware combinations would report a locally initiated
> disconnection even if the user turned Bluetooth off in the remote side.
> 
> Signed-off-by: Mikel Astiz <mikel.astiz@bmw-carit.de>
> ---
>  include/net/bluetooth/hci_core.h |    2 +-
>  include/net/bluetooth/mgmt.h     |    9 +++++++++
>  net/bluetooth/hci_event.c        |   26 +++++++++++++++++++++++---
>  net/bluetooth/mgmt.c             |    9 +++++----
>  4 files changed, 38 insertions(+), 8 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


