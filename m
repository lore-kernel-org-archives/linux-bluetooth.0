Return-Path: <cyrus@holtmann.org>
Date: Tue, 2 Oct 2012 21:52:27 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [PATCH v0] audio: Fix missing gateway state check on Connect
Message-ID: <20121002185227.GA26074@x220.P-661HNU-F1>
References: <1349200000-2696-1-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349200000-2696-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Tue, Oct 02, 2012, Mikel Astiz wrote:
> If the gateway is already connected (or connecting) when Connect() is
> called, an error should be returned, exactly as other interfaces do.
> ---
>  audio/gateway.c | 5 +++++
>  1 file changed, 5 insertions(+)

Applied. Thanks.

Johan
