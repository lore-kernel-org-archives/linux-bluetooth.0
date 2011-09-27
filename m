Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Sep 2011 12:14:32 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2 1/5] Remove storing device type
Message-ID: <20110927091432.GM3952@dell>
References: <1315572669-5006-2-git-send-email-claudio.takahasi@openbossa.org>
 <1316115103-19730-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1316115103-19730-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Thu, Sep 15, 2011, Claudio Takahasi wrote:
> Device type doesn't need to be stored since GATT services information
> exported through basic rate can be retrieved from the SDP records.
> Device "type" is also a wrong expression to represent the operation
> mode: over which transport GATT service is being exported.
> ---
>  src/adapter.c |   28 ----------------------------
>  src/device.c  |    2 --
>  src/storage.c |   38 --------------------------------------
>  src/storage.h |    3 ---
>  4 files changed, 0 insertions(+), 71 deletions(-)

All five patches applied. Thanks.

Johan
