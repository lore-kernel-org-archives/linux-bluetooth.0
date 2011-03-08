Return-Path: <cyrus@holtmann.org>
Date: Tue, 8 Mar 2011 09:41:16 +0000
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Rafal Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Adjust prefix of contact id for getting pb size
Message-ID: <20110308094116.GA3969@jh-x301>
References: <1298901223-8313-1-git-send-email-michalski.raf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1298901223-8313-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Mon, Feb 28, 2011, Rafal Michalski wrote:
> Getting phonebook size is related to recognizing contacts by their id
> prefixes. Previously it was "contact: " and has been changed to
> "urn:uuid:". This patch fixes it and allows to get valid phonebook size.
> ---
>  plugins/phonebook-tracker.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

I seem to have missed this one. It's now pushed upstream.

Johan
