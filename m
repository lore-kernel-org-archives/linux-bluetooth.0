Return-Path: <cyrus@holtmann.org>
Date: Tue, 21 Dec 2010 01:00:58 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 4/5] Fix missing reply when create device is
 cancelled
Message-ID: <20101220230058.GB6365@jh-x301>
References: <1292442852-26457-4-git-send-email-claudio.takahasi@openbossa.org>
 <1292885255-21662-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1292885255-21662-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Mon, Dec 20, 2010, Claudio Takahasi wrote:
> When CancelDeviceCreation is called or when the device is removed for
> any reason, the reply for the pending CreateDevice is not sent.
> ---
>  src/device.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)

Pushed upstream. Thanks.

Johan
