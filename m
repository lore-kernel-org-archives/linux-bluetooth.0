Return-Path: <cyrus@holtmann.org>
Date: Mon, 20 Dec 2010 17:36:06 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: anderson.lizardo@openbossa.org
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Fix memory leak of unused EIR name
Message-ID: <20101220153606.GA14575@jh-x301>
References: <1292852295-11104-1-git-send-email-anderson.lizardo@openbossa.org>
 <4d0f7725.81a5e60a.143c.2315@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4d0f7725.81a5e60a.143c.2315@mx.google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Mon, Dec 20, 2010, anderson.lizardo@openbossa.org wrote:
> There is a code path in btd_event_device_found() where the EIR name is
> not used. This requires freeing eir_data.name to avoid a leak.
> ---
>  src/event.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

Thanks. Pushed upstream.

Johan
