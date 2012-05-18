Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 May 2012 22:25:29 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [PATCH obexd v0 1/2] client: Fix NULL dereference in case of
 error
Message-ID: <20120518192529.GA14603@x220.P-661HNU-F1>
References: <1337327644-17920-1-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337327644-17920-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Fri, May 18, 2012, Mikel Astiz wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
> 
> obc_session_queue assumes that the given transfer is not NULL, so this
> must be checked explicitly.
> ---
>  client/manager.c |   16 ++++++++++++++--
>  1 files changed, 14 insertions(+), 2 deletions(-)

Both patches have been applied. Thanks.

Johan
