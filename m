Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110427175432.GA2328@joana>
References: <BANLkTi=UG0Xy2UEkNj2S_bS-PjOG5krNkQ@mail.gmail.com>
	<20110427175432.GA2328@joana>
Date: Thu, 28 Apr 2011 13:30:18 +0800
Message-ID: <BANLkTim=hU-D+174pFrksmA6Qimp9Xo1pA@mail.gmail.com>
Subject: Re: kernel panic after unplug usb bluetooth dongle
From: Dave Young <hidave.darkstar@gmail.com>
To: Dave Young <hidave.darkstar@gmail.com>,
	Bluettooth Linux <linux-bluetooth@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Apr 28, 2011 at 1:54 AM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> * Dave Young <hidave.darkstar@gmail.com> [2011-04-27 14:35:59 +0800]:
>
>> Hi,
>>
>> Unplug usb bluetooth dongle make kernel panic as below. Thomas, any
>> idea about it?
>
> Commit b79f44c16a4 on
>
>        git://git.kernel.org/pub/scm/linux/kernel/git/padovan/bluetooth-2.6.git
>
> fixes this. The only problem is that it didn't arrive at mainline yet.

Confirmed, thank you.

>
> --
> Gustavo F. Padovan
> http://profusion.mobi
>



-- 
Regards
dave
