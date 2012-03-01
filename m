Return-Path: <cyrus@holtmann.org>
Date: Wed, 29 Feb 2012 19:34:37 -0600
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Peter Krystad <pkrystad@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 1/5] Add L2CAP Create/Move Channel definitions
Message-ID: <20120301013437.GA26097@x220>
References: <1329332655-27394-1-git-send-email-pkrystad@codeaurora.org>
 <1329332655-27394-2-git-send-email-pkrystad@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329332655-27394-2-git-send-email-pkrystad@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Wed, Feb 15, 2012, Peter Krystad wrote:
> ---
>  lib/l2cap.h |   45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 45 insertions(+), 0 deletions(-)

I've applied this one to both bluez-hcidump.git as well as bluez.git
(after adding a lib: prefix that should be used for all lib patches).

Since any patches to lib/* should be appliable to both hcidump and bluez
please don't mix Makefile.am changes into them. Once you've split those
into separate patches I can apply them as well as the rest of this set.
Thanks.

Johan
