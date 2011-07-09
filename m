Return-Path: <cyrus@holtmann.org>
Date: Sat, 9 Jul 2011 19:20:34 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] Escape all text fields in vCard
Message-ID: <20110709162034.GD11005@dell.ger.corp.intel.com>
References: <1309873531-1418-1-git-send-email-lkslawek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1309873531-1418-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Tue, Jul 05, 2011, Slawomir Bochenski wrote:
> This adds previously missing escaping of some text attributes in vCards.
> ---
>  plugins/vcard.c |   82 ++++++++++++++++++++++++++++++++-----------------------
>  1 files changed, 48 insertions(+), 34 deletions(-)

This doesn't apply to latest git either.

Johan
