Return-Path: <cyrus@holtmann.org>
Date: Wed, 22 Sep 2010 10:22:22 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jaikumar Ganesh <jaikumar@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix Headset Audio gateway SDP record.
Message-ID: <20100922072222.GA5358@jh-x301>
References: <1285113932-16299-1-git-send-email-jaikumar@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1285113932-16299-1-git-send-email-jaikumar@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaikumar,

On Tue, Sep 21, 2010, Jaikumar Ganesh wrote:
> Headset Audio Gateway does not have the Supported Features
> in the SDP records according to the HSP specification.
> ---
>  tools/sdptool.c |    6 +-----
>  1 files changed, 1 insertions(+), 5 deletions(-)

Thanks. The patch has been pushed upstream.

Johan
