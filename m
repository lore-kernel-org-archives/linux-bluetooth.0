Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Aug 2010 01:35:24 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ron Shaffer <rshaffer@codeaurora.org>
Cc: Matthew Wilson <mtwilson@codeaurora.org>,
	linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: Re: [PATCH v2] Firmware download for Qualcomm Bluetooth devices
Message-ID: <20100818223524.GA19592@jh-x301>
References: <4C620A8A.9030707@codeaurora.org>
 <1281713636-24955-1-git-send-email-mtwilson@codeaurora.org>
 <4C6BFF05.5040506@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4C6BFF05.5040506@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ron,

On Wed, Aug 18, 2010, Ron Shaffer wrote:
> On 8/13/2010 10:33 AM, Matthew Wilson wrote:
> > Configures device address from hciattach parameter.
> > UART speed limited to 115200.
> > Requires separate device specific firmware.
> > ---
> >  Makefile.tools             |    3 +-
> >  tools/hciattach.c          |    8 ++
> >  tools/hciattach.h          |    1 +
> >  tools/hciattach_qualcomm.c |  279 ++++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 290 insertions(+), 1 deletions(-)
> >  create mode 100644 tools/hciattach_qualcomm.c
<snip>
> Ping

Sorry about forgetting about this one. Unfortunately it doesn't apply
anymore to bluez.git due to the ath3k patches that got merged earlier
today. So you'll need to fix the conflicts and resubmit. Other than that
the patch seems fine to me.

Johan
