Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAo+LNOnDtHYjfLAQXj3Tgqiibd+oyKJP9109TfoGaDuAbmgag@mail.gmail.com>
References: <CAAo+LNOnDtHYjfLAQXj3Tgqiibd+oyKJP9109TfoGaDuAbmgag@mail.gmail.com>
Date: Sun, 6 Mar 2016 16:44:24 +0200
Message-ID: <CABBYNZLqxCSN6cViGY07e44C40i4Puvi7PqJtqhM6kDXWj_qaw@mail.gmail.com>
Subject: Re: BTLE pairing sequence problem
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrew - <hidefromkgb@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrew,

On Sun, Mar 6, 2016 at 1:16 AM, Andrew - <hidefromkgb@gmail.com> wrote:
>> why don't you look at the source code. We have a smp_c1() in net/bluetooth/smp.c in \
>> the kernel (including actual test vectors). And there is also bt_crypto_c1() in \
>> src/shared/crypto.c in BlueZ userspace.
>
> Shame on me, but static analysis of the kernel code has never been a
> strong point of mine.
> So, the only built-in test case for smp_c1() that I found is called
> test_c1(), and it contains the very case described in the standard.
>
> As for userspace tools, I found out that they yield same results as my
> code (and the former kernel code, apparently): see the attached source
> file. When the second, real-life test case is commented out,
> everything is ok.
> Unfortunately, none of the uses of bt_crypto_c1() explain why calling
> it with inputs set to legitimate values and exact packet captures does
> not produce the captured result. Everything seems to comply, and I`m
> sure that the problem is some insanely subtle detail I fail to
> understand.
>
>> And on a side note, the PDUs from pairing request / response need to fed into c1 as \
>> they are received over the air. Meaning you can not mask out bits and then feed it \
>> in. That has been clarified in an erratum and especially important for LE Secure \
>> Connections (which Linux does support).
>
> Exactly as I do, actually.
> Or do I? Are these request/response packet dumps I got on my capture
> the ones that have to be put into _pres and _preq variables from the
> code attached?

I don't remember having any problems pairing the Designer Keyboard,
how did you actually connected to it? Note, recently there was a
problem with GATT services where errors such as authentication
required did not elevate the security which in turn would cause an
attempt to pair if not paired yet, perhaps that is the source of your
problem here, however if you did call Device.Pair that should start
the pairing procedure immediately.

-- 
Luiz Augusto von Dentz
