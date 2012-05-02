Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 May 2012 14:41:18 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v1] audio: Reset hfp and hs handle before connection
Message-ID: <20120502114118.GA20389@x220.ger.corp.intel.com>
References: <1335958590-9249-1-git-send-email-jaganath.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335958590-9249-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Wed, May 02, 2012, Jaganath Kanakkassery wrote:
> When bluez initiates headset connection  hfp and hs handle is saved
> each time when initiating connection. So at some point if hf service
> is removed in remote headset then bluez connects to hs service. But
> because of previously stored hfp handle bluez thinks that connection
> made to hs service is hfp connection and waits for at commands.
> Eventually bluez connection state will be incorrectly set.
> ---
>  audio/headset.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

Applied. Thanks.

Johan
