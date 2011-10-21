Return-Path: <cyrus@holtmann.org>
Date: Fri, 21 Oct 2011 13:36:00 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add eir length parameter to eir_parse()
Message-ID: <20111021103600.GA4205@fusion.localdomain>
References: <1319191823-17377-1-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1319191823-17377-1-git-send-email-frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Fri, Oct 21, 2011, Frédéric Danis wrote:
> LE use shorter eir (31 bytes) than HCI (240 bytes)
> ---
>  plugins/hciops.c  |   22 +++++++++-------------
>  plugins/mgmtops.c |    3 ++-
>  src/adapter.c     |    4 ++--
>  src/adapter.h     |    2 +-
>  src/eir.c         |    6 +++---
>  src/eir.h         |    2 +-
>  src/event.c       |    5 +++--
>  src/event.h       |    2 +-
>  unit/test-eir.c   |    2 +-
>  9 files changed, 23 insertions(+), 25 deletions(-)

Applied. Thanks.

Johan
