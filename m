Return-Path: <cyrus@holtmann.org>
Date: Tue, 28 Jun 2011 11:02:40 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd v2] Fix crash introduced by
 f5279bfcedd669bc5d4e88cc1c59807c92226dfb
Message-ID: <20110628080240.GE18047@dell.ger.corp.intel.com>
References: <1308652632-2028-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1308652632-2028-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Jun 21, 2011, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The callback function actually needs the bluetooth_service structure not
> obex_service_driver.
> ---
>  plugins/bluetooth.c |   25 +++++++++++++------------
>  1 files changed, 13 insertions(+), 12 deletions(-)

Applied. Thanks.

Johan
