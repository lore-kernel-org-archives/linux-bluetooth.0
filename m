Return-Path: <cyrus@holtmann.org>
Date: Wed, 9 Sep 2009 20:55:51 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Peter Hurley <phurley@charter.net>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/1] Fixed duplicate attempt from device to connect
	'signalling' channel
Message-ID: <20090909175551.GA24276@jh-x301>
References: <20090908222839.GA25653@jh-x301> <1252517135-7753-1-git-send-email-phurley@charter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1252517135-7753-1-git-send-email-phurley@charter.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Wed, Sep 09, 2009, Peter Hurley wrote:
> A device may attempt to initiate a duplicate avdtp channel while
> a host-initiated channel connection is still pending. This
> situation is referred to as 'XCASE connect:connect' in sink.c and
> source.c. This fix rejects the device-initiated connection in this
> circumstance.
> ---
>  audio/avdtp.c |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)

Thanks a lot! The patch has been pushed upstream (with a few more very
minor coding style changes).

Johan
