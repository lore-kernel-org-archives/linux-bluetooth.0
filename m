Return-Path: <cyrus@holtmann.org>
Date: Mon, 17 Oct 2011 14:10:35 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] fix build
Message-ID: <20111017111035.GA19306@fusion.localdomain>
References: <1318848980-569-1-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1318848980-569-1-git-send-email-frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Mon, Oct 17, 2011, Frédéric Danis wrote:
> src/eir.c: In function ‘eir_parse’:
> src/eir.c:72: error: ‘name_len’ may be used uninitialized in this function
> 
> and
> 
> thermometer/thermometer.c: In function ‘destroy_char’:
> thermometer/thermometer.c:79: error: implicit declaration of function ‘g_slist_free_full’
> ---
>  src/eir.c                 |    2 +-
>  thermometer/thermometer.c |    5 +++++
>  2 files changed, 6 insertions(+), 1 deletions(-)

Strange. Current git compiles just fine under Fedora 16 beta (gcc 2.6.1)
as well as debian unstable (also gcc 2.6.1). Which gcc version do you
use?

I'd push the patch upstream but it fails to apply:

	fatal: cannot convert from UTF-8utf-8 to UTF-8

I suspect that's because of the double Content-Type header in your
email. Could you try to fix it?

Johan
