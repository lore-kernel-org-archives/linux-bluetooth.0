Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <688D0E41-320E-43A3-9722-462851431685@holtmann.org>
References: <1371655718-1753-1-git-send-email-jesse.sung@canonical.com>
	<688D0E41-320E-43A3-9722-462851431685@holtmann.org>
Date: Fri, 21 Jun 2013 16:43:33 +0800
Message-ID: <CAH10aOgLow_+R2AOcKFtW4aT08LmQ7JCBvQ-ULL8SVYDpNg4Xg@mail.gmail.com>
Subject: Re: [PATCH 1/5] Bluetooth: Support for loading broadcom patchram firmware
From: Jesse Sung <jesse.sung@canonical.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, Anthony Wong <anthony.wong@canonical.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

2013/6/20 Marcel Holtmann <marcel@holtmann.org>:
> following what we did for the Intel devices is obviously the right way here.
>
> However that said, we used the Intel setup part to test the handling of the changes we build for doing the actual setup. Long term plan is still to create a mini-driver framework.
>
> So drivers like the Intel one and Broadcom patchram will become their own module providing just the setup routing and sharing everything else via exportable functions from btusb.ko.
>
> Would you like to help our guys to get this mini-driver framework into a mergable shape?

Hi Marcel,

Sure, I'm glad to participate. :)

Thanks,
Jesse
