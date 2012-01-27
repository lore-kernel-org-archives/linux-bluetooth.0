Return-Path: <cyrus@holtmann.org>
Date: Fri, 27 Jan 2012 12:50:13 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [PATCH obexd] client: fix possible glib assertion failure
Message-ID: <20120127105013.GA25201@x220>
References: <1327592024-1644-1-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1327592024-1644-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Thu, Jan 26, 2012, Mikel Astiz wrote:
> In case of error there might be no io channel to shutdown.
> ---
>  client/bluetooth.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)

Applied. Thanks.

Johan
