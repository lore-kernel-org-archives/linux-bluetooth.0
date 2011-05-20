Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4DD675D5.1030601@ethicstech.in>
References: <4DD675D5.1030601@ethicstech.in>
Date: Fri, 20 May 2011 19:11:15 +0200
Message-ID: <BANLkTimFfLJxwyTM2MNcVeEMC2n+r2MsHA@mail.gmail.com>
Subject: Re: How to test ssp pairing in linux
From: Bartosz Szatkowski <bulislaw@linux.com>
To: Siva kumar <sivakumar@ethicstech.in>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, May 20, 2011 at 4:08 PM, Siva kumar <sivakumar@ethicstech.in> wrote:
> Hi all,
>
>           I had an android mobile with ssp pairing ssp pairing support, i
> want to check ssp pairing. When i try to pair with pc it asks for pin. i
> don't known how to enable ssp pairing in pc, i am using ubuntu 9.10
>
> Regards
> sivakumar
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Hi,
what is Your BlueZ version? Also on some (older) Android devices
(ROMs) there is no SSP, (not sure whether agent version matters eg
bluetooth-applet).
In other cases SSP should be used by default.

-- 
Pozdrowienia,
Bartosz Szatkowski
