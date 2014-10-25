Return-Path: <cyrus@holtmann.org>
Date: Sat, 25 Oct 2014 16:33:36 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alfonso Acosta <fons@spotify.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v5 0/2] core: Add plugin-support for Manufacturer
 Specific Data EIR
Message-ID: <20141025143336.GA1125@t440s>
References: <1413816661-19290-1-git-send-email-fons@spotify.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1413816661-19290-1-git-send-email-fons@spotify.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alfonso,

On Mon, Oct 20, 2014, Alfonso Acosta wrote:
> v5:
> 
> * rebased
> * fixed warning
> * fixed android compilation error
> 
> v4:
> 
> * Support for multiple MSD fields in the same EIR data block.
> * Moved parsing to a separate function: eir_parse_msd()
> 
> v3:
> 
> * Corrections suggested by Johan on the handling of eir.h
> * Parser sanity check on the size of the MSD payload.
> * Minor typo correction on commit message.
> 
> Alfonso Acosta (2):
>   core: Add Manufacturer Specific Data EIR field
>   core: Add subscription API for Manufacturer Specific Data
> 
>  src/adapter.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  src/adapter.h | 10 ++++++++++
>  src/eir.c     | 22 ++++++++++++++++++++++
>  src/eir.h     | 10 ++++++++++
>  4 files changed, 87 insertions(+)

Both of these patches have been applied. Note that I made a small change
to the first one to avoid a dependency on hci.h (by having a dedicated
define in eir.h).

Johan
