Return-Path: <cyrus@holtmann.org>
Date: Fri, 17 Feb 2012 16:43:13 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] audio: Fix signature of MediaTransport.Acquire
 method
Message-ID: <20120217144313.GB5494@x220>
References: <1329488256-12998-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329488256-12998-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Feb 17, 2012, Luiz Augusto von Dentz wrote:
> Acquire returns the input and output MTUs in addition to the file
> descriptor, but the signature doesn't indicate that.
> ---
>  audio/transport.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
