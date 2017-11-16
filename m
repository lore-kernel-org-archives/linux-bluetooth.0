Return-Path: <amitkarwar@gmail.com>
MIME-Version: 1.0
In-Reply-To: <440EED52-0556-4919-9727-078B2A7192D6@holtmann.org>
References: <1510730444-3237-1-git-send-email-amitkarwar@gmail.com>
 <1510730444-3237-3-git-send-email-amitkarwar@gmail.com> <440EED52-0556-4919-9727-078B2A7192D6@holtmann.org>
From: Amitkumar Karwar <amitkarwar@gmail.com>
Date: Thu, 16 Nov 2017 10:42:27 +0530
Message-ID: <CAEhWJFn+t69YL6vXjSeRZw1hPggReOSFP6g0xTv8qYPiJv=UDg@mail.gmail.com>
Subject: Re: [PATCH 2/8] rsi: add bluetooth rx endpoint
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Kalle Valo <kvalo@codeaurora.org>, linux-wireless <linux-wireless@vger.kernel.org>,
	Amitkumar Karwar <amit.karwar@redpinesignals.com>,
	Prameela Rani Garnepudi <prameela.j04cs@gmail.com>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	Siva Rebbagondla <siva.rebbagondla@redpinesignals.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Nov 15, 2017 at 8:53 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Amitkumar,
>
>> USB endpoint 1 is used for WLAN which is presently in use.
>> USB endpoint 2 is introduced for BT Rx traffic. Enumeration
>> of Rx BT endpoint and submitting Rx BT URB are added.
>
> wouldn=E2=80=99t it be good to include the /sys/kernel/debug/usb/devices =
part here that shows how the USB device=E2=80=99s layout.

Sure. We will do this in updated version.

Regards,
Amitkumar
