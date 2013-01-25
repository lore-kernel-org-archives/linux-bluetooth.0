Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 Jan 2013 18:30:59 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] adapter: Fix not removing a device when the
 adapter is down
Message-ID: <20130125163059.GA7646@x220.P-661HNU-F1>
References: <1359124259-31316-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1359124259-31316-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Fri, Jan 25, 2013, Vinicius Costa Gomes wrote:
> It is a documented error that MGMT_UNPAIR_DEVICE should return an
> error if the controller is not powered.
> 
> This error is being ignored, and if the user asks for a device to be
> removed while the controller is powered down, the keys associated with
> that device will still be in the kernel side.
> 
> The solution is to return the user an error when it is asked to remove
> a device and the controller is not powered.
> ---
>  src/adapter.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied. Thanks.

Johan
