Return-Path: <cyrus@holtmann.org>
Date: Wed, 29 Feb 2012 19:47:04 -0600
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [PATCH obexd v2 1/2] client: fix unreported canceled transfers
Message-ID: <20120301014704.GF26492@x220>
References: <1330433782-23492-1-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330433782-23492-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Tue, Feb 28, 2012, Mikel Astiz wrote:
> A session can be shut down from D-Bus, and therefore the pending
> transfer callbacks must be reported.
> ---
>  client/session.c |   15 ++++++++++++++-
>  1 files changed, 14 insertions(+), 1 deletions(-)

Both patches have been applied. Thanks.

Johan
