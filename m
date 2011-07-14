Return-Path: <cyrus@holtmann.org>
Date: Thu, 14 Jul 2011 17:34:33 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi
Subject: Re: [PATCH v2 1/3] Fix read_pin_code to return ssize_t
Message-ID: <20110714143433.GA11928@dell.ger.corp.intel.com>
References: <1310564415-26093-1-git-send-email-dh.herrmann@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1310564415-26093-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Wed, Jul 13, 2011, David Herrmann wrote:
> read_pin_code returns the length of a memory block and hence should use
> ssize_t as type.
> ---
>  src/event.c   |    2 +-
>  src/storage.c |    4 ++--
>  src/storage.h |    2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)

All three patches have been applied. Thanks.

Johan
