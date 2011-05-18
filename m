Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 May 2011 16:49:01 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Bruna Moreira <bruna.moreira@openbossa.org>
Subject: Re: [PATCH v6 12/12] Drop variable EIR length
Message-ID: <20110518234901.GA26030@dell.amr.corp.intel.com>
References: <1305747614-19823-1-git-send-email-claudio.takahasi@openbossa.org>
 <1305754457-28124-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1305754457-28124-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Wed, May 18, 2011, Claudio Takahasi wrote:
> The functions eir_parse() and adapter_update_found_devices() now
> assume that the EIR buffer has always 240 octets. For advertising
> reports, the advertising data is stored on a buffer with 240 bytes,
> padded with zeroes.
> ---
>  plugins/hciops.c |   13 +++++++++----
>  src/adapter.c    |    6 +++---
>  src/adapter.h    |    4 ++--
>  src/eir.c        |    8 ++++----
>  src/eir.h        |    2 +-
>  src/event.c      |    3 +--
>  6 files changed, 20 insertions(+), 16 deletions(-)

All patches in this set have now been pushed upstream. Thanks.

Johan
