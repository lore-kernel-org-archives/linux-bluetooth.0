Return-Path: <cyrus@holtmann.org>
Date: Tue, 26 Jul 2011 13:38:42 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bartosz Szatkowski <bulislaw@linux.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] Fix proper data escaping for vCard listing
Message-ID: <20110726103842.GB5470@dell>
References: <1311256507-10744-1-git-send-email-bulislaw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1311256507-10744-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bartosz,

On Thu, Jul 21, 2011, Bartosz Szatkowski wrote:
> Up until now it was possible to inject some XML or just broke returned
> vCard listing by preparing contact with some special characters.
> ---
>  plugins/pbap.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
