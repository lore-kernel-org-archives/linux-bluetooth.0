Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 Feb 2011 17:41:08 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] hcitool: fix interval and window parameters
Message-ID: <20110224204108.GB30774@jh-x301>
References: <1298573768-26751-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1298573768-26751-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi André,

On Thu, Feb 24, 2011, Andre Guedes wrote:
> Set interval and window parameters properly if --discovery option
> is present in lescan command.
> 
> According to the Bluetooth spec, during a general or limited discovery
> procedure the scan interval and the scan window should be set to
> 11.25 ms. If --discovery option isn't present, both parameters are set
> to the default value (10 ms) defined in LE Set Scan Parameters Command.
> 
> According to that command description, the interval and window parameters
> should be set as follows:
> 
> 	Time = N * 0.625 msec
> 
> So, in order to set the time values to 11.25 and 10 ms, the parameters
> should be equal to 18 (0x0012) and 16 (0x0010), respectively.
> ---
>  tools/hcitool.c |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)

Pushed upstream. Thanks.

Johan
