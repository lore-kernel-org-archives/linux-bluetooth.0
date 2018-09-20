Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
References: <CACjvaw=rr-MDiBZH6rM1BORBH372ZXLkSrxpPsKjP6dMGo4TZg@mail.gmail.com>
 <CABBYNZLTfTLUavm6uELEx-Xvei__+7qv-zb+=ih9ckHUvPmOMw@mail.gmail.com> <CAAu3APYPjb58hDZJ2imnp1Hrxi8JVsun_HnJfuQHFXNdfuZ1Qg@mail.gmail.com>
In-Reply-To: <CAAu3APYPjb58hDZJ2imnp1Hrxi8JVsun_HnJfuQHFXNdfuZ1Qg@mail.gmail.com>
From: Nazmul Alam <fadedreamz@gmail.com>
Date: Thu, 20 Sep 2018 12:09:17 -0400
Message-ID: <CACjvawnYg3kBnrDhMdbDo++y-nN0wX1CqCYFRNFrgVn4a0Ethg@mail.gmail.com>
Subject: Re: Problem with two dongle simultaneously
To: Barry Byford <31baz66@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz and Barry,
Thank you for the suggestions. I will try the latest bluez out.

Regarding pygatt, I can double confirm they are using gatttool on the
binary distribution provided by python package manager.

Given that I used pygatt to get the data, I was evaluating the dbus
c-api for data capture. But I don't wanted to jump into premature
decision as I didn't know it this is an issue on the bluez side (if
that was the case, no point using dbus api).

Thank you again and I will get back once I do the testing.
On Thu, Sep 20, 2018 at 10:06 AM Barry Byford <31baz66@gmail.com> wrote:
>
> Hi Luiz,
>
> On Thu, 20 Sep 2018 at 10:16, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>
> > Btw, pygatt appears to be using gatttool which is deprecated, not idea
> > why people keep using that.
> It seems they are aware of the situation:
> https://github.com/peplin/pygatt/issues/112
>
> I suspect part of the problem is that the "wrong" answers are easier
> to find with your favorite search engine....
