Return-Path: <cyrus@holtmann.org>
Date: Mon, 7 Jan 2013 16:20:58 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] adapter: Fix storage to be used by BlueZ 4 or 5
Message-ID: <20130107142058.GA13984@x220.P-661HNU-F1>
References: <1357556011-9493-1-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1357556011-9493-1-git-send-email-frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Mon, Jan 07, 2013, Frédéric Danis wrote:
> Conversion should be performed only one time, but using "converted"
> entry in device related files generates a bogus device object with
> dev_CONVERTED path when starting BlueZ 4.
> 
> If "settings" file has been created we've done the conversion and
> we can use it to check if conversion has already been done.
> 
> Remove "converted" entries in converted files
> ---
>  src/adapter.c |  177 +++++++++++++++++++++++++++++++--------------------------
>  1 file changed, 95 insertions(+), 82 deletions(-)

Applied. Thanks.

Johan
