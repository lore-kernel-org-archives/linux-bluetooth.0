Return-Path: <drake@endlessm.com>
MIME-Version: 1.0
In-Reply-To: <20180525095452.5203-1-jian-hong@endlessm.com>
References: <20180525095452.5203-1-jian-hong@endlessm.com>
From: Daniel Drake <drake@endlessm.com>
Date: Fri, 25 May 2018 07:25:58 -0600
Message-ID: <CAD8Lp456sVtCrC0cMHXQV-PCXq12GfOjtmCpwuguF_=c-1YyaA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add a new Realtek 8723DE ID 0bda:b009
To: Jian-Hong Pan <jian-hong@endlessm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>, Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jian-Hong,

On Fri, May 25, 2018 at 3:54 AM, Jian-Hong Pan <jian-hong@endlessm.com> wrote:
>
> Without this patch we cannot turn on the Bluethooth adapter on HP
> 14-bs007la.

Please correct me if I'm wrong, but it looks like we are still waiting
for the testing of this patch from our colleagues in Guatemala.

There are unlikely to be any issues with such a trivial change, but we
should probably wait for confirmation that it works before having it
included upstream.

Thanks
Daniel
