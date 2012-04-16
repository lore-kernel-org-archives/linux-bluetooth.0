Return-Path: <cyrus@holtmann.org>
Date: Mon, 16 Apr 2012 22:56:33 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 0/3] SDP build warning and EIR parsing
Message-ID: <20120416195633.GB7541@x220.ger.corp.intel.com>
References: <1334581298-11877-1-git-send-email-s.syam@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334581298-11877-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

On Mon, Apr 16, 2012, Syam Sidhardhan wrote:
> This patchset is sending as per my discussion with Johan over the IRC#bluez.
> The first patch is: While building the code with the maintainer mode enable,
> is throwing warning and further it leads to a build break in different cross
> compilation environment.
> 
> The second and third patch is related to the EIR parsing.
> Since the eir_length() parsing return value is incorrect, we are appending
> the COD at incorrect location. As a result, while retrieving back we are
> unable to get the COD back during emiting device found signal during discovery.
> 
> The same fix is required in the eir_has_data_type() aswell.
> 
> Syam Sidhardhan (3):
>   sdp: Fix compilation warning due to data type mismatch
>   eir: Fix incorrect eir_length() parsing
>   eir: Fix incorrect eir_has_data_type() parsing
> 
>  lib/sdp.c |    2 +-
>  src/eir.c |    8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)

Applied. Thanks.

Johan
