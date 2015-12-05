Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH v3] Bluetooth: btintel: Add manufacturing enter/exit helpers
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1449155422-25683-1-git-send-email-loic.poulain@intel.com>
Date: Sat, 5 Dec 2015 08:16:04 -1000
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <5AB03690-EBCE-4B33-8F98-4344B6F961D9@holtmann.org>
References: <1449155422-25683-1-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> Older Intel controllers need to enter manufacturing mode to perform
> some vendor specific operations (patching, configuration...).
> Add enter/exit manufaturing methods and refactor existing
> manufacturing code.
> Exit can be configured to perform a reset. Reset can be performed
> either with patches activated or deactivated.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> v2: add static definition if !CONFIG_BT_INTEL
> v3: add comment on manufaturing exit behavior
> 
> drivers/bluetooth/btintel.c | 114 +++++++++++++++++++++++---------------------
> drivers/bluetooth/btintel.h |  12 +++++
> drivers/bluetooth/btusb.c   |  54 ++++++---------------
> 3 files changed, 86 insertions(+), 94 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

