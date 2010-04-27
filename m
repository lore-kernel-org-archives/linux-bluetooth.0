Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Apr 2010 13:15:32 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Santiago Carot Nemesio <scarot@libresoft.es>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] SDP memory checks
Message-ID: <20100427101532.GB6555@jh-x301>
References: <1272353139.2157.8.camel@mosquito>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1272353139.2157.8.camel@mosquito>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Apr 27, 2010, Santiago Carot Nemesio wrote:
> This patch add some memory checks after malloc is called. Also some
> blank spaces at the end of the lines are removed.  I observed that
> sometimes functions returns NULL or 0 without any convention. I set
> all to NULL to formalice the source code.

Thanks for the patch. It looks good, but could you split it into two
parts: one patch for the coding style fixes (whitespace, changing 0 to
NULL, etc) and another one to fix the missing malloc error checks. Also
use "git format-patch" to create the patches so that they can be easily
applied using "git am".

Johan
