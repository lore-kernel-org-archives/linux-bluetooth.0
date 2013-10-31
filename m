Return-Path: <cyrus@holtmann.org>
Date: Thu, 31 Oct 2013 16:52:47 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/5] android: Add support for starting and cancelling
 device discovery
Message-ID: <20131031145247.GA32078@x220.p-661hnu-f1>
References: <1383229534-17157-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383229534-17157-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Thu, Oct 31, 2013, Jakub Tyszkowski wrote:
> Android will cancel ongoing discovery after some period of time so there
> is no need for another timeout inside the daemon itself.
> 
> ---
>  android/adapter.c | 108 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 107 insertions(+), 1 deletion(-)

All five patches have been applied. Thanks.

Johan
