Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH v2 1/3] Bluetooth: btintel: Add Device Configuration support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1441382076-7737-1-git-send-email-loic.poulain@intel.com>
Date: Fri, 4 Sep 2015 09:03:29 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <97C88BC3-D48C-4342-BFA0-25E6445A2F33@holtmann.org>
References: <1441382076-7737-1-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> btintel_load_ddc_config retrieves the ddc file and sends its content
> via DDC commands (opcode 0xfc8b).
> 
> The ddc file should contain one or more DDC structures.
> A DDC structure is composed of the folowing fields:
> field: | DDC LEN |    DDC ID    |   DDC VALUE   |
> size:  | 1 byte  |    2 bytes   |  DDC LEN - 2  |
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> v2: rename btintel_ddc_send into btintel_load_ddc_config
> 
> drivers/bluetooth/btintel.c | 46 +++++++++++++++++++++++++++++++++++++++++++++
> drivers/bluetooth/btintel.h |  7 +++++++
> 2 files changed, 53 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

