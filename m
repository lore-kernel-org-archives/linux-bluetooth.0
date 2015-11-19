Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAKafyqpQwmUOHwH8j68kkni_k8F4pKAKE674w1pvAuL91GjrAw@mail.gmail.com>
References: <CAKafyqpQwmUOHwH8j68kkni_k8F4pKAKE674w1pvAuL91GjrAw@mail.gmail.com>
Date: Thu, 19 Nov 2015 15:15:36 +0200
Message-ID: <CABBYNZLDkFBz3TMEyOCZdbfberwA_Z9FEBwbDhAWQxbpSZ4XBA@mail.gmail.com>
Subject: Re: HoG: Report Map Sharing is not Happening all the time.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Prabhu Chawandi <foss.chaws@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Prabhu,

On Thu, Nov 19, 2015 at 8:33 AM, Prabhu Chawandi <foss.chaws@gmail.com> wrote:
> Hi All,
>
>   In My bluetooth Smart Keyboard sometimes though connection is
> established key presses were not being received by application. I
> tried running 'evtest' /dev/input/eventX node was not created when the
> issue was seen. After some debug I found the Report Maps were not
> shared. [i dint see the log when run bluetoothd -d
>
> 1. Is it necessary to share report map all the time system is reboot ?
> 2. is the Report map not cached ? or Cached which system failed to pick ?

The report map is lost every time you restart bluetoothd, that is
because we only cache attribute handles but not theirs values since it
would be way too expensive the read and store everything, so what
happens is that during the first time you connect to a HoG peripheral
bluetoothd will attempt to read the report map and create the input
device but perhaps there is something causing a problem in your case.

> Please let me know your views.
>
> many thanks,
> Prabhu Chawandi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
