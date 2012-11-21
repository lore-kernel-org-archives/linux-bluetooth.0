Return-Path: <cyrus@holtmann.org>
Date: Wed, 21 Nov 2012 14:34:48 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3] neard: Set device class in device object
Message-ID: <20121121123448.GA14499@x220>
References: <1353499163-18479-1-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1353499163-18479-1-git-send-email-frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frederic,

On Wed, Nov 21, 2012, Frédéric Danis wrote:
> As soon as we have info related to a new device,
> device object will be created if it does not exist yet.
> 
> Change check_device() to use this device object and
> remove call to adapter_remove_device() in it.
> ---
>  plugins/neard.c |   32 +++++++++++++++-----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)

Applied. Thanks.

Johan
