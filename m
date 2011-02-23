Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Feb 2011 11:49:26 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Check malformed notification/indication PDU
Message-ID: <20110223144904.GB26355@jh-x301>
References: <1298463393-25123-1-git-send-email-epx@signove.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1298463393-25123-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Elvis,

On Wed, Feb 23, 2011, Elvis Pf??tzenreuter wrote:
> This patch implements discard of obviously malformed
> GATT notification/indication PDUs.
> ---
>  attrib/client.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)

Pushed upstream. Thanks.

Johan
