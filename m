Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH v3 3/4] Bluetooth: hci_intel: Add runtime PM support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1441188254-15507-3-git-send-email-loic.poulain@intel.com>
Date: Wed, 2 Sep 2015 08:30:46 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <181885AD-1761-43C4-8916-CB3C42576232@holtmann.org>
References: <1441188254-15507-1-git-send-email-loic.poulain@intel.com> <1441188254-15507-3-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> Implement runtime PM suspend/resume callbacks.
> If LPM supported, controller is put into supsend after a delay of
> inactivity (1s). Inactivity is based on LPM idle notification and
> host TX traffic.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> v2: Add pm_runtime comments.
>    Use same suspend/resume callbacks for pm and runtime pm.
> v3: Fix 'list' indentation.
>     Move cancel_work before set_power(0)
> 
> drivers/bluetooth/hci_intel.c | 72 +++++++++++++++++++++++++++++++++++++++++--
> 1 file changed, 69 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

