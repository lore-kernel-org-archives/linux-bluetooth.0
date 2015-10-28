Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHmfHqS_jW0vLA14wMz939BNV1XKzUr7BG+_h_4Xzq1LywLz+w@mail.gmail.com>
References: <CAHmfHqTrHGpwyxaP6rsBNk5FamFxJMFBy547UY21vQLdLSDc4Q@mail.gmail.com>
 <CABBYNZLjPt_vCcW5JswbK+utJvVm8SbEAus7dw0jt+fW3Q8Fug@mail.gmail.com>
 <CAHmfHqQjBKrW+HhjDLaNQPcvYwnzYtm=2WJUhAgKUyyAS-AW7A@mail.gmail.com>
 <CABBYNZJbZzuFQNYSmMmXNv3zWPBsvtFSTvFKroCyyQndDPrw7Q@mail.gmail.com> <CAHmfHqS_jW0vLA14wMz939BNV1XKzUr7BG+_h_4Xzq1LywLz+w@mail.gmail.com>
From: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Date: Wed, 28 Oct 2015 05:43:08 +0100
Message-ID: <CAEZxfGPPoYOX=yGDP2TQFRw7GY_zCXZrPYuDxxK8jt49veyjyg@mail.gmail.com>
Subject: Re: Cannot write to BLE thermal printer
To: Leon Nicholls <lnicholls@google.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

You may want to simply try:

crosh> bt_console
[bluetooth]# scan on
Discovery started
...
[bluetooth]# scan off
Discovery stopped
[bluetooth]# connect 01:23:45:67:89:01

where 01:23:45:67:89:01 is the Bluetooth Low Energy printer address.

On Wed, Oct 28, 2015 at 3:59 AM Leon Nicholls <lnicholls@google.com> wrote:
>
> In my web app I don't explicitly do a scan for devices. That is done
> somewhere inside the polymer element or even the Web Bluetooth API in
> Chrome. I'm going to experiment with using the Web Bluetooth API
> directly to eliminate one level of abstraction.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
