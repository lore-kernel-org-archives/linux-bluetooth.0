Return-Path: <sedat.dilek@gmail.com>
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
In-Reply-To: <CA+icZUXaGZ73kj8R8AKCoakyCXf14sj0i4nJc7HER27SfM_YKQ@mail.gmail.com>
References: <CA+icZUWf1EyPJDOTO-xos=QwQ0DWLOg3goiSX_X2C01QpVqU1w@mail.gmail.com>
 <D83A359C-829A-4DBC-B5CE-1B077CE6B0E4@holtmann.org> <CA+icZUUD92VO52MtynBBQFFPxWkj=pvhm0yDkMYNamvVG4ry9Q@mail.gmail.com>
 <1083ECDC-2292-4372-B85D-DA551EB3FB38@holtmann.org> <CA+icZUVT-fJwamHBSUfHW1KOQU6gx3OeKWgbo7B5oTYmK5dm7g@mail.gmail.com>
 <984B6D8C-483D-46C7-A746-2BB28B262F87@holtmann.org> <CA+icZUXaGZ73kj8R8AKCoakyCXf14sj0i4nJc7HER27SfM_YKQ@mail.gmail.com>
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Mon, 12 Jun 2017 10:26:55 +0200
Message-ID: <CA+icZUWd-qpToPpkP-UhPswH2_nyC8YxqwBiU-7=ivcia5RAHQ@mail.gmail.com>
Subject: Re: [Linux-4.9.30] Broadcom BCM20702 bluetooth in ThinkPad-T530 not usable
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jun 12, 2017 at 10:03 AM, Sedat Dilek <sedat.dilek@gmail.com> wrote:
> Hi Marcel,
>
> I have rebuilt net/bluetooth and drivers/bluetooth kernel-modules
> "the-debian-kernel-way".
> For build-instructions see attached howto file.

It is sufficient just to rebuild net/bluetooth exactly bluetooth.ko
kernel-module and copy this new file.
To be on the safe side I rebooted into my system.

>
> Can you please give appropriate credits like...
>
>      Reported-by:Sedat Dilek <sedat.dilek@gmail.com
>      Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
>

Missed ">"...

Reported-by:Sedat Dilek <sedat.dilek@gmail.com>

- Sedat -
