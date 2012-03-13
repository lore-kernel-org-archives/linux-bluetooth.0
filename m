Return-Path: <cyrus@holtmann.org>
Date: Tue, 13 Mar 2012 15:54:14 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [PATCH v1 1/3] audio: fix missing unref in case of error
Message-ID: <20120313135414.GA2224@x220.P-661HNU-F1>
References: <1331644796-14314-1-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331644796-14314-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Tue, Mar 13, 2012, Mikel Astiz wrote:
> audio_adapter_get() increases the reference counter of the adapter, so
> it's necessary to decrement it in case of error.
> ---
>  audio/manager.c |   21 ++++++++++++++++++---
>  1 files changed, 18 insertions(+), 3 deletions(-)

All patches in this set have been applied. Thanks.

Johan
