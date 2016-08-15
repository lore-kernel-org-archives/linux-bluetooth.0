Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALe7QMA-kexji4xo_P1usXg5JVE=BrqfxUJALa9Fd1Azv-ejJQ@mail.gmail.com>
References: <CALe7QMApaeG0orTAXL_s2VWeDnkG1af60Fp5Eu6U5SjhHitMvw@mail.gmail.com>
 <CABBYNZJgssL4rL2-p10wOHuMtMR20aH1aY7RHUNx+EdcUM3qAA@mail.gmail.com> <CALe7QMA-kexji4xo_P1usXg5JVE=BrqfxUJALa9Fd1Azv-ejJQ@mail.gmail.com>
From: Wilson Perez <wilsonpp@gmail.com>
Date: Mon, 15 Aug 2016 09:23:26 -0400
Message-ID: <CALe7QMAzxXfPi0tCR04dSKKBR=RUc2dLfT0qG8ckBqxk=VB2ew@mail.gmail.com>
Subject: Fwd: BlueZ5: Unable to re-pair device after unpairing
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thank you, Luiz.  I have tested successfully removing the device
manually and paring afterwards.  Is there a way to allow either by
configuration or patch subsequent pairing requests of already paired
devices in a Bluetooth controller?  This condition would take place
when, say, a phone is paired with a Bluetooth controller, later
unpaired by the phone's internal capabilities, and finally attempting
to pair once again with the Bluetooth controller.  Bluez 3.36 allowed
this capability.

Thank you so much.

Wilson



On Mon, Aug 15, 2016 at 3:56 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Wilson,
>
> On Mon, Aug 15, 2016 at 5:22 AM, Wilson Perez <wilsonpp@gmail.com> wrote:
> > I am using BlueZ 5.41 on ARM Linux 4,1,18 and would like to be able to
> > pair a device that had previously been paired but then unpaired.  How
> > can this be accomplished?
>
> You can do that by removing the device and then pairing again.
>
> --
> Luiz Augusto von Dentz
