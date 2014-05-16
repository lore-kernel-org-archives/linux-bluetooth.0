Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Antonio Ospite <ao2@ao2.it>
Cc: linux-bluetooth@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Szymon Janc <szymon.janc@gmail.com>,
	Frank Praznik <frank.praznik@oh.rr.com>
Subject: Re: [PATCHv2 BlueZ 0/5] plugin/sixaxis: Set leds using the sysfs leds class
Date: Fri, 16 May 2014 14:37:46 +0200
Message-ID: <11971268.CcPvClF73V@uw000953>
In-Reply-To: <1400103605-25183-1-git-send-email-ao2@ao2.it>
References: <1399370776-5027-1-git-send-email-ao2@ao2.it> <1400103605-25183-1-git-send-email-ao2@ao2.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Antonio,

On Wednesday 14 of May 2014 23:40:01 Antonio Ospite wrote:
> Hi,
> 
> here's the updated patch series, the commit messages have been fixed too!
> 
> I am leaving out patch 1/5 for now:
> 
>   plugins/sixaxis: Simplify get_js_numbers()
> 
> I decided to do so because there is still some timing issue: the new
> procedure to retrieve the js number is faster, and on the _very_first_
> run it fails and returns 0, I suspect this has to do with the fact that
> the joydev module gets loaded after the hidraw uevent and the
> enumeration in the plugin completes before the js node shows up in
> sysfs, I'll do some more experiments on that.
> 
> So please apply only patches from 2 to 5, thanks, I kept the numbering
> as in v1 for clarity.
> 
> Changes since v1 are annotated in each patch.
> 
> The changes have been tested with libudev-204 along with linux-3.13,
> linux 3.14 and linux-3.15-rc4. 
> 
> To recap:
>   - on kernels < 3.14 the hidraw mechanism is used
>   - on kernels >= 3,14 the sysfs mechanism is used to avoid
>     inconsistencies with rumble effects.
> 
> Thanks,
>    Antonio
> 
> Antonio Ospite (4):
>   plugins/sixaxis: Factor out a set_leds_hidraw() function
>   plugins/sixaxis: Factor out a calc_leds_bitmap() function
>   plugins/sixaxis: Add a get_leds_data() function
>   plugins/sixaxis: Add a set_leds_sysfs() function
> 
>  configure.ac      |   4 +-
>  plugins/sixaxis.c | 178 +++++++++++++++++++++++++++++++++++++++++++++++-------
>  2 files changed, 158 insertions(+), 24 deletions(-)

I've applied patches 2/5 and 3/5 so no need to resend those. Thanks.

-- 
Best regards, 
Szymon Janc
