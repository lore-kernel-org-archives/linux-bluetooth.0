Return-Path: <cyrus@holtmann.org>
Date: Thu, 4 Aug 2011 14:03:49 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3] audio: add profile version to HandsfreeAgent
Message-ID: <20110804110349.GA21591@dell>
References: <1312378457-12732-1-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1312378457-12732-1-git-send-email-frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Wed, Aug 03, 2011, Frédéric Danis wrote:
> Some phones with HFP Audio Gateway version previous to 1.5 (i.e.
> Samsung SGH-D600 returning 0x0101 as profile version) do not accept
> an AT+BRSF with latest features.
> The Handsfree agent should adapt its AT+BRSF command depending on the
> remote version, so add version information as parameter of
> NewConnection method.
> ---
>  audio/gateway.c |   87 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  doc/hfp-api.txt |    2 +-
>  2 files changed, 87 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
