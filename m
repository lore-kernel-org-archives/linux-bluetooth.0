Return-Path: <mka@chromium.org>
Date: Mon, 25 Jun 2018 16:00:50 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, rtatiya@codeaurora.org,
	hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v8 2/7] Bluetooth: btqca: Rename ROME specific functions
 to Generic functions
Message-ID: <20180625230050.GG129942@google.com>
References: <20180625134013.19684-1-bgodavar@codeaurora.org>
 <20180625134013.19684-3-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180625134013.19684-3-bgodavar@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Seems you have to respin anyway due to comments in other patches, so I
squeeze in some optional improvements of the commit message.

> Subject: Rename ROME specific functions to Generic functions

nit: s/Generic/generic/

On Mon, Jun 25, 2018 at 07:10:08PM +0530, Balakrishna Godavarthi wrote:
> Some of the QCA BTSoC ROME functions, are used for different versions
> or different make of BTSoC's. Instead of duplicating the same functions
> for new chip, updating names of the functions that are used for both

nit: s/updating/update/

> chip's to keep this generic and would help in future when we would have

nit: s/chip's/chips/

> new BT SoC

nit: you might want to start a new sentence here, it's a long churn to
read :) optionally you could just say 'logs' instead of 'bt_dev_info,
bt_dev_err and bt_dev_dbg'.

> and to have generic text in bt_dev_info, bt_dev_err and
> bt_dev_dbg updated from ROME to QCA where ever possible. This avoids
> confusion to user, when using the future Qualcomm Bluetooth SoC's.
> Updated BT_DBG, BT_ERR and BT_INFO with bt_dev_dbg, bt_dev_err and
> bt_dev_info where ever applicable.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
