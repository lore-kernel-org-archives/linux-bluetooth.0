Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Antonio Ospite <ao2@ao2.it>
Cc: linux-bluetooth@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Frank Praznik <frank.praznik@oh.rr.com>
Subject: Re: [PATCHv3 BlueZ 0/5] plugin/sixaxis: Set leds using the sysfs leds class
Date: Sun, 08 Jun 2014 14:58:41 +0200
Message-ID: <4054390.v7N5YFnDZ8@athlon>
In-Reply-To: <1401189915-2092-1-git-send-email-ao2@ao2.it>
References: <1400103605-25183-1-git-send-email-ao2@ao2.it> <1401189915-2092-1-git-send-email-ao2@ao2.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Antonio,

On Tuesday 27 May 2014 13:25:13 Antonio Ospite wrote:
> Hi,
> 
> here's the updated patch series.
> 
> Fixes to get_js_numbers() are coming later.
> 
> Thanks,
>    Antonio
> 
> 
> Antonio Ospite (2):
>   plugins/sixaxis: Add a get_leds_data() function
>   plugins/sixaxis: Add a set_leds_sysfs() function
> 
>  configure.ac      |   4 +-
>  plugins/sixaxis.c | 132
> +++++++++++++++++++++++++++++++++++++++++++++++++----- 2 files changed, 123
> insertions(+), 13 deletions(-)

Both patches applied. Thanks.

-- 
Szymon K. Janc
szymon.janc@gmail.com
