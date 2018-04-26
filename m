Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180420160353.5cb58146@windsurf.numericable.fr>
References: <20180420130254.20063-1-luiz.dentz@gmail.com> <20180420160353.5cb58146@windsurf.numericable.fr>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 26 Apr 2018 15:49:42 +0300
Message-ID: <CABBYNZ+TVoNcT_=URtBN8e=JNiDRChVhqCDO1dx+wd0GnEV7aw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] build: Make bt_shell conditional to readline
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Apr 20, 2018 at 5:03 PM, Thomas Petazzoni
<thomas.petazzoni@bootlin.com> wrote:
> Hello,
>
> On Fri, 20 Apr 2018 16:02:54 +0300, Luiz Augusto von Dentz wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> bt_shell APIs shall only be build if readline is present on the system
>> since it currently depend on it.
>
> Tested-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
>
> I've tested with a few different BlueZ configurations (not all
> combinations though), and all of them built fine. The specific
> configuration that was failing to build due to the dependency on
> readline no longer fails to build.
>
> Thanks a lot Luiz for having looked so quickly at this bug report!

Applied.

-- 
Luiz Augusto von Dentz
