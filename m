Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <5511CDE3.2000004@message-id.googlemail.com>
References: <5511CDE3.2000004@message-id.googlemail.com>
Date: Thu, 26 Mar 2015 11:40:39 +0200
Message-ID: <CABBYNZKtV8rSRoWvSUao-hoY6ds2pRc+VsHM4ik8cFf0kpuFRQ@mail.gmail.com>
Subject: Re: More testsuite breakage unveiled by gcc-5.0
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Stefan Seyfried <stefan.seyfried@googlemail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stefan,

On Tue, Mar 24, 2015 at 10:49 PM, Stefan Seyfried
<stefan.seyfried@googlemail.com> wrote:
> Hi all,
>
> the test suite apparently has more problems unveiled by gcc-5.0
>
> The gory details are in
> https://bugzilla.opensuse.org/show_bug.cgi?id=923768
>
> I'm off to conferences / vacation now, so my latency will be big :-)

Thanks for reporting, I will be looking into that, apparently this
only happen on 32 bits but I managed to reproduce with gcc 4.9.2 as
well.


-- 
Luiz Augusto von Dentz
