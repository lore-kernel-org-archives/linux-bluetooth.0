Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 Jul 2012 15:53:45 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC BlueZ] storage: Remove support for trusted services
Message-ID: <20120730125345.GB16470@x220.ger.corp.intel.com>
References: <1343420349-18877-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343420349-18877-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Fri, Jul 27, 2012, Vinicius Costa Gomes wrote:
> Since a long time, it is impossible to set individual services as
> trusted using our API, so there's no need to have support for storing
> this kind of information.
> ---
> Hi,
> 
> Do you think it is useful to still maintain support for reading that kind of
> information? That "feature" was removed in the 3 -> 4 transition as deprecated.
> 
> Cheers,
> 
>  src/device.c  |    9 +----
>  src/storage.c |  119 +++++++--------------------------------------------------
>  src/storage.h |    6 +--
>  3 files changed, 19 insertions(+), 115 deletions(-)

I think this does make sense so the patch is now upstream. Thanks.

Johan
