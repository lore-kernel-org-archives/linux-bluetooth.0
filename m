Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAF1PxS=UkQ-bXDg+DfTUVoU4uxkh7K-5pxv_s3KUoUOooQ0xQ@mail.gmail.com>
References: <CAAF1PxS=UkQ-bXDg+DfTUVoU4uxkh7K-5pxv_s3KUoUOooQ0xQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 6 Jul 2016 17:17:40 +0300
Message-ID: <CABBYNZJcs7pqhTht3Sq-THwYfE4kkrLqBRjv9+vewbNYhoBhXw@mail.gmail.com>
Subject: Re: BlueZ supported features/profiles
To: Mun Choy Wong <munchoy@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Jul 5, 2016 at 6:08 PM, Mun Choy Wong <munchoy@gmail.com> wrote:
> I am looking for the information on what profiles or features are
> supported by BlueZ.
> There are 2 places that I can find such information, one is in the
> BlueZ official website and another one is in the release package from
> a file called supported-features.txt, it looks to me that the text
> file is better with more details but could anyone here please confirm
> that I can rely on it?

The repository file is probably the most accurate.

> Also, if the features or profiles are not listed, i.e. TCS-BIN
> protocols, then is this not supported?

 - TCS-BIN is only used by the cordless telephony profile, which
failed to attract implementers. As such it is only of historical
interest.
https://en.wikipedia.org/wiki/Bluetooth#TCS

BlueZ has been used mostly in mobile, pc and headsets/IVI environments
so that the profiles you should expect.

You may also implement your own profiles with the following APIs:

https://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/profile-api.txt

-- 
Luiz Augusto von Dentz
