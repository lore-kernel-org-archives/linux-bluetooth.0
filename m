Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTimbj=p1ecddQsTiun6LUeP8+wPnT0VLCsvsWNRb@mail.gmail.com>
References: <AANLkTimbj=p1ecddQsTiun6LUeP8+wPnT0VLCsvsWNRb@mail.gmail.com>
From: "Arun K. Singh" <arunkat@gmail.com>
Date: Mon, 21 Feb 2011 13:34:16 +0530
Message-ID: <AANLkTi=PmKr3edHQ-AgFKRJQXOF6A1+Uc+bmTXyrW960@mail.gmail.com>
Subject: Re: bluetooth kernel to bluez userspace relationship
To: Viswanathan Sankararam <developervishwa@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vish,

> All,
> I'm new to bluetooth so please forgive me for asking this question if
> its already been answered. I understand that the linux kernel has part
> of the bluetooth stack and there is also the rest of it called Bluez
> in userspace which consists of a daemon and library. How would one
> correlate linux kernel version with the bluez userspace version?
> Meaning, how would l know say, linux-2.6.35 would work with
> Bluez-4.68.
>
> Any response would be appreciated.

unless you are looking for a specific feature in bluez-userspace you
must use latest kernel and bluez version. If you are cherry-picking an
old bluez version you need to check recent feature enhancements into
same, which may require a matching kernel version. for example for AMP
manager or Bt 3.0 stuff, you may need an ERTM enabled kernel which
comes only 2.6.35 onwards ...

Even if you intend to use an old Bluez userspace, its always advisable
to pick latest kernel ...else you need to dig ..


> Thanks
> Vish
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--
Best Regards,
Arun K. Singh
www.crazydaks.com
