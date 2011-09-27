Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Sep 2011 12:29:58 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Fix Device UUIDs property list being sent empty
Message-ID: <20110927092957.GZ3952@dell>
References: <1316438570-10054-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1316438570-10054-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Mon, Sep 19, 2011, Claudio Takahasi wrote:
> When creating a new device, the UUIDs list is updated in the device
> probing function. This patch moves the function call which emit the
> signal after the device driver probing.
> ---
>  src/device.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
