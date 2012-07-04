Return-Path: <cyrus@holtmann.org>
Date: Wed, 4 Jul 2012 15:42:04 +0300
From: Johan Hedberg <johan.hedberg@intel.com>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: hicattach: fix return length after reading the patch file
Message-ID: <20120704124204.GC24179@x220.ger.corp.intel.com>
References: <1898220.KzhPWWYfm0@tedd-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1898220.KzhPWWYfm0@tedd-ubuntu>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,

On Mon, Jul 02, 2012, Tedd Ho-Jeong An wrote:
> From: Tedd Ho-Jeong AN <tedd.an@intel.com>
> 
> This patch fixes the issue that returns alwasy 0 after reading the patch line.
> 
> ---
>  tools/hciattach_intel.c |    7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Applied. Thanks.

For the future, please pay attention to the correctness of your commit
messages. I had to fix two typos in this one.

Johan
