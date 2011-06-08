Return-Path: <cyrus@holtmann.org>
Date: Wed, 8 Jun 2011 10:01:37 +0900
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Pawlik <lucas.pawlik@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix type in conditional expression
Message-ID: <20110608010137.GA7145@dell.ccr.corp.intel.com>
References: <1307019272-19810-1-git-send-email-lucas.pawlik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1307019272-19810-1-git-send-email-lucas.pawlik@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Thu, Jun 02, 2011, Lukasz Pawlik wrote:
> Function media_endpoint_create returns pointer to structure. In
> conditional expression it is safer to compare returned value with NULL
> and not with gboolean as it is done in register_endpoint function.
> ---
>  audio/media.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
