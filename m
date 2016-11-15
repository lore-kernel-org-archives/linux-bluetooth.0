Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAFHyJTpWdNvKgvx8SGRWBVyR7PjR=kCZMjyUuFL+rb1D5_wmLA@mail.gmail.com>
References: <CAFHyJTpWdNvKgvx8SGRWBVyR7PjR=kCZMjyUuFL+rb1D5_wmLA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 15 Nov 2016 11:18:11 +0200
Message-ID: <CABBYNZL37MnF-iXkPo1XP=v4eVXQV-OuxyRSqkY3m1q1Q0Tawg@mail.gmail.com>
Subject: Re: multiple buffer overflows and out-of-bound reads
To: "op7ic \\x00" <op7ica@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Nov 14, 2016 at 7:06 PM, op7ic \x00 <op7ica@gmail.com> wrote:
> Hello list,
>
> I have been playing with hcidump tool recently and came across
> following bugs coming from either out-of-bound reads or buffer
> overflows  (see attached reports).
>
> There are couple more I`m working on and will send these later.

I guess we want these to be tested against btmon, hcidump is a deprecated.

-- 
Luiz Augusto von Dentz
