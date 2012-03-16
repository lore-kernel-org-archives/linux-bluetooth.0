Return-Path: <cyrus@holtmann.org>
Date: Fri, 16 Mar 2012 12:29:31 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Brian Gix <bgix@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/1] Bluetooth: Fix corruption of device_connected pkt
Message-ID: <20120316152931.GH20650@x220>
References: <1331330823-11496-1-git-send-email-bgix@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331330823-11496-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On Fri, Mar 09, 2012, Brian Gix wrote:
> Incorrect pointer passed to eir_append_data made mgmt_device_connected
> event unparsable by mgmt user space entity.
> 
> Signed-off-by: Brian Gix <bgix@codeaurora.org>
> ---
>  net/bluetooth/mgmt.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied to my bluetooth-next tree. Thanks.

Johan
