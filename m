Return-Path: <cyrus@holtmann.org>
Message-ID: <1323900538.1965.60.camel@aeonflux>
Subject: Re: [PATCH 3/7] Bluetooth: Remove mgmt_set_service_cache
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 14 Dec 2011 23:08:58 +0100
In-Reply-To: <1323899524-13653-4-git-send-email-johan.hedberg@gmail.com>
References: <1323899524-13653-1-git-send-email-johan.hedberg@gmail.com>
	 <1323899524-13653-4-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Instead of having an explicit service cache command we can make the mgmt
> API simpler by implicitly enabling the cache when mgmt_read_info is
> called for the first time and disabiling it when mgmt_set_dev_class is

it is "disabling".

> called.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    4 +++
>  include/net/bluetooth/mgmt.h     |    5 ---
>  net/bluetooth/hci_sock.c         |    7 +++-
>  net/bluetooth/mgmt.c             |   56 +++++---------------------------------
>  4 files changed, 16 insertions(+), 56 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


