Return-Path: <mka@chromium.org>
Date: Wed, 19 Sep 2018 10:26:48 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 0/1] Cold on & off support for Qualcomm BT chip wcn3990
Message-ID: <20180919172648.GR22824@google.com>
References: <20180919152113.7611-1-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180919152113.7611-1-bgodavar@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

nit: Not sure there is much value in a cover letter for a 'series'
with a single patch. The changelog and additional comments (if needed)
can be placed in the post with the patch below '---'.

On Wed, Sep 19, 2018 at 08:51:12PM +0530, Balakrishna Godavarthi wrote:
> This patch will power off regulators while hci0 down and turn on them 
> back on hci0 up. Every time we power off we call proto specific close
> function, so that we will free the memory of Qualcomm BT specific buffers.
> Will call proto open to assign the memory and turn on the regulators, before
> calling qualcomm setup.
> 
> v2:
>    * Removed vendor specific hdev->open and close functions.
>    * Added hdev->shutdown function to turn off the regs.	
> 	
> v1:
>    * initial patch.
> 
> Balakrishna Godavarthi (1):
>   Bluetooth: hci_qca: Add poweroff support during hci down for wcn3990
> 
>  drivers/bluetooth/hci_qca.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
