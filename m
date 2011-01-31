Return-Path: <cyrus@holtmann.org>
Date: Mon, 31 Jan 2011 10:40:38 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Add option to enable privacy during scanning to
 hcitool
Message-ID: <20110131084038.GB10034@jh-x301>
References: <1296254017-3381-1-git-send-email-claudio.takahasi@openbossa.org>
 <1296254017-3381-2-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1296254017-3381-2-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Fri, Jan 28, 2011, Claudio Takahasi wrote:
> When privacy is enabled, random address is used during active scanning.
> The non-resolvable private address shall be set using hciconfig.
> ---
>  tools/hcitool.c |   13 +++++++++----
>  1 files changed, 9 insertions(+), 4 deletions(-)

Both patches have been pushed upstream. Thanks.

Any plans how to represent this feature in the official APIs? I suppose
the random address can be generated automatically using some appropriate
source such as the HCI_LE_Rand command but how do we represent the
public vs random address selection using the D-Bus API? Or do we even
need to do that?

Johan
