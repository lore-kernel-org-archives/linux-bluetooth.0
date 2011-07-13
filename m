Return-Path: <cyrus@holtmann.org>
Date: Wed, 13 Jul 2011 11:53:38 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com, ulrik.lauren@stericsson.com
Subject: Re: [PATCH v2] Add SAP driver for ST-Ericsson U8500 platform
Message-ID: <20110713085338.GD15147@dell.ger.corp.intel.com>
References: <CAJdJm_MgPgniRrnExvWoavJTZObDzDUJSUno5z-DoqEaV8+t1w@mail.gmail.com>
 <1309860226-16919-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1309860226-16919-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Jul 05, 2011, Szymon Janc wrote:
> ---
>  Makefile.am     |    4 +-
>  sap/sap-u8500.c |  708 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 710 insertions(+), 2 deletions(-)
>  create mode 100644 sap/sap-u8500.c

The patch has been applied, thanks. I had to fix whitespace in the
sim2sap_result table first though.

Johan
