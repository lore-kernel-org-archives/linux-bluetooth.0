Return-Path: <cyrus@holtmann.org>
Date: Sat, 23 Oct 2010 10:31:11 -0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Tommi Keisala <ext-tommi.keisala@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] This patch avoids a crash when org.bluez.Manager
 GetProperties request is received and there is not yet any adapters ready.
 Happens often for example when bluetoothd and ofonod is started next ot
 each other.
Message-ID: <20101023123111.GB19333@jh-x301>
References: <1287811998-20490-2-git-send-email-ext-tommi.keisala@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1287811998-20490-2-git-send-email-ext-tommi.keisala@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tommi,

On Sat, Oct 23, 2010, Tommi Keisala wrote:
> ---
>  src/manager.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

You seem to have somehow managed to screw up the commit message this
time: everything in the summary line and nothing in the message body.
Anyway, to avoid further feedback rounds (since the patch itself is fine
now) I went ahead and fixed the commit message and pushed your patch
upstream. Thanks.

Johan
