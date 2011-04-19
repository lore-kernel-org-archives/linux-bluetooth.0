Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTi=Ei91GRcL2oP0G16LDy7mpLoDEGQ@mail.gmail.com>
References: <BANLkTi=Ei91GRcL2oP0G16LDy7mpLoDEGQ@mail.gmail.com>
Date: Tue, 19 Apr 2011 15:46:17 +0800
Message-ID: <BANLkTi=-RnUyuC2VGuRix_J4KOx+9BhroQ@mail.gmail.com>
Subject: Re: [BUG] bluetooth doesn't work from 2.6.39-rc1+ to 2.6.39-rc3+
From: Dave Young <hidave.darkstar@gmail.com>
To: Hui Zhu <teawater@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Bluettooth Linux <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Apr 19, 2011 at 10:53 AM, Hui Zhu <teawater@gmail.com> wrote:
> Cannot connect to any outside devices through bluetooth.
>
> And I think this is not a bug of low level driver.  Because both my
> laptop and a usb bluetooth card cannot work.

Hi, please explain the "cannot work" in detail,
Firstly check dmesg and hciconfig to see if there's anything wrong.

-- 
Regards
dave
