Return-Path: <cyrus@holtmann.org>
Date: Wed, 26 Jan 2011 15:36:48 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Rafal Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2 v3] Fix fetching non-empty single owner vCard
Message-ID: <20110126133648.GA13737@jh-x301>
References: <1296048387-2854-1-git-send-email-michalski.raf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1296048387-2854-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Wed, Jan 26, 2011, Rafal Michalski wrote:
> Previously only empty owner vCard fetching was handled.
> This patch makes that fetching empty (by default) and non-empty
> (filled somehow by the user) single owner vCard is handled.
> ---
>  plugins/phonebook-tracker.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

Pushed upstream. Thanks.

Johan
