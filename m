Return-Path: <cyrus@holtmann.org>
Date: Thu, 7 Jun 2012 09:25:38 +0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ido Yariv <ido@wizery.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] gattrib: Fix a premature response timer removal
Message-ID: <20120607012538.GA2953@x220>
References: <1338980175-14980-1-git-send-email-ido@wizery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338980175-14980-1-git-send-email-ido@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ido,

On Wed, Jun 06, 2012, Ido Yariv wrote:
> A timer is set when a response is expected. The timer is removed when
> data is received, regardless of whether or not the data is a response.
> As a result, the timer may be cleared even though a response was not
> received and there would be no way to detect a command timeout.
> 
> Fix this by clearing the timer only after verifying a response was
> received.
> ---
>  attrib/gattrib.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)

Applied. Thanks.

Johan
