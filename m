Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Jun 2009 20:03:32 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] test/agent.c: pairing via CreatePairedDevice
Message-ID: <20090630170332.GA9971@jh-x301>
References: <1246379557-16538-1-git-send-email-filippo@esaurito.net> <1246379557-16538-2-git-send-email-filippo@esaurito.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1246379557-16538-2-git-send-email-filippo@esaurito.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Filippo,

(alread went through this on IRC but replying here too so that there's a
trace in the list archives)

On Tue, Jun 30, 2009, Filippo Giunchedi wrote:
> introduce optional argument target for remote address, if passed pairing
> will be called
> ---
>  test/agent.c |   60 +++++++++++++++++++++++++++++++++++++++++++++++++++------
>  1 files changed, 53 insertions(+), 7 deletions(-)

All three patches are now pushed upstream.

Things that'd need fixing next:

- Use "adapter" when referring to local adapters and "device" when
  referring to remote devices

- Related to the previous item, why does the help text say "--device
  interface"? Isn't it used for an adapter path? (i.e. it should say
  "--adapter path")

- Implement the missing SSP callbacks

Johan
