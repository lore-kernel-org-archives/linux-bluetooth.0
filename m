Return-Path: <bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 09 Jul 2018 22:27:18 +0530
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 rtatiya@codeaurora.org, hemantg@codeaurora.org, c-hbandi@codeaurora.org,
 linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v1 0/1] Enable subsystem restart for Qualcomm bluetooth
 chip wcn3990.
In-Reply-To: <20180709161657.26609-1-bgodavar@codeaurora.org>
References: <20180709161657.26609-1-bgodavar@codeaurora.org>
Message-ID: <813ada2b431a86d4d4e59ac2dfb845b8@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Forgot to add this patch is on top of
Following patches. Which are under review

https://patchwork.kernel.org/patch/10510029/
https://patchwork.kernel.org/patch/10510031/
https://patchwork.kernel.org/patch/10510037/
https://patchwork.kernel.org/patch/10510045/
https://patchwork.kernel.org/patch/10510033/
https://patchwork.kernel.org/patch/10510051/
https://patchwork.kernel.org/patch/10510047/

On 2018-07-09 21:46, Balakrishna Godavarthi wrote:
> In many platforms Bluetooth chip wcn3990 is a discrete chip connected
> via UART lines to app processor. if the chip goes into bad state
> i.e. into hard fault exception routine, which will not further respond
> to any commands from HOST via UART. In that case wcn3390 will intimate
> HOST by generating hardware error. Host stack will initiate a close
> and reopen of the hci driver. Prior to sending hard ware error, wcn3990
> has a capability of sending the RAM dump i.e. memory dump of the BT 
> chip.
> this will help us to fix stability issues of the SoC. We at QCA driver
> read the dump packets and store via devcoredump().
> We perform restart after collecting the ram dump of the SoC.
> 
> 
> Harish Bandi (1):
>   Bluetooth: hci_qca: Sub system restart support for WCN3990
> 
>  drivers/bluetooth/btqca.h   |   8 ++
>  drivers/bluetooth/hci_qca.c | 261 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 269 insertions(+)

-- 
Regards
Balakrishna.
