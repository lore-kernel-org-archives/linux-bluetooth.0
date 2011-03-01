Return-Path: <cyrus@holtmann.org>
Date: Tue, 1 Mar 2011 16:02:26 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Rafal Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Adjust prefix of contact id for pulling single vCard
Message-ID: <20110301190226.GC32583@jh-x301>
References: <1298894632-30497-1-git-send-email-michalski.raf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1298894632-30497-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Mon, Feb 28, 2011, Rafal Michalski wrote:
> Pulling single vCard is related to recognizing it by prefix of contact
> id. Previously it was "contact: " and has been changed to "urn:uuid:".
> This patch fixes it and allows to pull valid single vCard.
> ---
>  plugins/phonebook-tracker.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Pushed upstream. Thanks.

Johan
