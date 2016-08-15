Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALe7QMApaeG0orTAXL_s2VWeDnkG1af60Fp5Eu6U5SjhHitMvw@mail.gmail.com>
References: <CALe7QMApaeG0orTAXL_s2VWeDnkG1af60Fp5Eu6U5SjhHitMvw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 15 Aug 2016 10:56:49 +0300
Message-ID: <CABBYNZJgssL4rL2-p10wOHuMtMR20aH1aY7RHUNx+EdcUM3qAA@mail.gmail.com>
Subject: Re: BlueZ5: Unable to re-pair device after unpairing
To: Wilson Perez <wilsonpp@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Wilson,

On Mon, Aug 15, 2016 at 5:22 AM, Wilson Perez <wilsonpp@gmail.com> wrote:
> I am using BlueZ 5.41 on ARM Linux 4,1,18 and would like to be able to
> pair a device that had previously been paired but then unpaired.  How
> can this be accomplished?

You can do that by removing the device and then pairing again.

-- 
Luiz Augusto von Dentz
