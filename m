Return-Path: <cyrus@holtmann.org>
Date: Tue, 1 Feb 2011 10:30:03 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2 v3] Fix creating device object when connection fails
Message-ID: <20110201083003.GA3785@jh-x301>
References: <1296548930-23062-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1296548930-23062-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Feb 01, 2011, Luiz Augusto von Dentz wrote:
> There is no need to create a new object since there is no connection and
> the device is not permanent/paired.
> ---
>  src/event.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)

Thanks. This one has been pushed upstream now. I'll skip 2/2 since it
should never happen that there's a connection without a corresponding
device object.

Johan
