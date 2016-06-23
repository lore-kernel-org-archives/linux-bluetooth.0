Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CA+ZaN3-=bpNt0NVudLQQ9AR83gWVzvURnArQzcUEmYqGEL9tXQ@mail.gmail.com>
References: <CA+ZaN3-=bpNt0NVudLQQ9AR83gWVzvURnArQzcUEmYqGEL9tXQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 23 Jun 2016 14:29:22 +0300
Message-ID: <CABBYNZK+QFVZJTYmynmfO+Zo-_1Dib2S8KnjmAjo=C_8Jfeagg@mail.gmail.com>
Subject: Re: Why is BLE still under -E option?
To: Seulki Shin <sskcorea@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slki,

On Thu, Jun 23, 2016 at 10:54 AM, Seulki Shin <sskcorea@gmail.com> wrote:
> Hi Bluez,
>
> BLE is getting important these days.
> However we have to rebuild Bluez to use BLE features.
> Why don't we have BLE feaures open?

I guess you are talking about GATT, we are working in making them
stable but we need feedback from users if the API is proper, recently
I made some changes adding flags for ReadValue and WriteValue to cover
some GATT server requirements coming for Web folks.

-- 
Luiz Augusto von Dentz
