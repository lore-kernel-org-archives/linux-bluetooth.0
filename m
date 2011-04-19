Return-Path: <cyrus@holtmann.org>
Date: Wed, 20 Apr 2011 00:58:07 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: anderson.briglia@openbossa.org
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Add basic discovery commands to the
 management interface
Message-ID: <20110419215807.GA26778@jh-x301>
References: <4dae0084.a905ec0a.709a.12f6@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4dae0084.a905ec0a.709a.12f6@mx.google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Briglia,

On Tue, Apr 19, 2011, anderson.briglia@openbossa.org wrote:
> From: Johan Hedberg <johan.hedberg@nokia.com>
> 
> This patch adds start_discovery and stop_discovery commands to the
> management interface. Right now their implementation is fairly
> simplistic and the parameters are fixed to what user space has
> defaulted to so far.
> This is the very initial phase for discovery implementation into
> the kernel. Next steps include name resolution, LE scanning and
> bdaddr type handling.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
> Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
> ---
>  include/net/bluetooth/mgmt.h |    4 ++
>  net/bluetooth/mgmt.c         |   77 +++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 80 insertions(+), 1 deletions(-)

I'd appreciate it if you'd check with me first before going about
sending patches in my name that I haven't 100% authored. There are e.g.
some coding style things I'd have cleaned up before making this public.
Depending on the amount of code changed (maybe not enough for this case
though) you could have even put yourself as author and simply mentioned
"Based on original code by Johan..." somewhere in the commit message.

Johan
