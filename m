Return-Path: <cyrus@holtmann.org>
Date: Thu, 15 Mar 2012 10:13:28 +0000
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Arik Nemtsov <arik@wizery.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] device: don't auto-connect on disc-cb attio callback
 registration
Message-ID: <20120315101328.GA1343@x220.vexbr.com.br>
References: <1331214279-27521-1-git-send-email-arik@wizery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331214279-27521-1-git-send-email-arik@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arik,

On Thu, Mar 08, 2012, Arik Nemtsov wrote:
> If a device is already connected, don't auto-connect if we register
> a disconnect-only attio callback. This will obviously fail.
> ---
>  src/device.c |   13 +++++++++----
>  1 files changed, 9 insertions(+), 4 deletions(-)

Both patches have been applied. Thanks.

Johan
