Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: How to initialise bcm4354A2 with 3.10 kernel?
To: Qingtao Cao <qingtao.cao.au@gmail.com>,
	linux-bluetooth@vger.kernel.org
References: <CAPcThSGPMaqJ9zr5fPWM38YH+2DE5M7a5oBNM4pUa3g1Xdba1w@mail.gmail.com>
From: lpoulain <loic.poulain@intel.com>
Message-ID: <575A749A.1090409@intel.com>
Date: Fri, 10 Jun 2016 10:04:42 +0200
MIME-Version: 1.0
In-Reply-To: <CAPcThSGPMaqJ9zr5fPWM38YH+2DE5M7a5oBNM4pUa3g1Xdba1w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Harry,

> Dear community,
> r
> I am trying to use the brcm_patchram_plus program to initialise
> broadcom bcm4354A2 on my target with 3.10 Linux kernel. Currently the
> hci0 can be found UP, however, it doesn't seem to function properly.

Did you try to init the chip with hciattach (bcm43xx) ?
If yes, do you reproduce the same issue ?

Regards,
Loic
