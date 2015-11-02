Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+JewnhDgsCdxhM9XT-9_Y7fRMMMhsaPgMdoNe0+Kka8A@mail.gmail.com>
References: <CAHmfHqTrHGpwyxaP6rsBNk5FamFxJMFBy547UY21vQLdLSDc4Q@mail.gmail.com>
 <CABBYNZLjPt_vCcW5JswbK+utJvVm8SbEAus7dw0jt+fW3Q8Fug@mail.gmail.com>
 <CAHmfHqQjBKrW+HhjDLaNQPcvYwnzYtm=2WJUhAgKUyyAS-AW7A@mail.gmail.com>
 <CABBYNZJbZzuFQNYSmMmXNv3zWPBsvtFSTvFKroCyyQndDPrw7Q@mail.gmail.com>
 <CAHmfHqS_jW0vLA14wMz939BNV1XKzUr7BG+_h_4Xzq1LywLz+w@mail.gmail.com>
 <CAEZxfGPPoYOX=yGDP2TQFRw7GY_zCXZrPYuDxxK8jt49veyjyg@mail.gmail.com>
 <CAHmfHqQLmiGep3nKZ-Vq8RHqvG-SwVJhvUJSnDJZ6+jGeAFXpg@mail.gmail.com>
 <CAEZxfGPdU0fzp_P-7AJDSF+xCnXPqVUHs8fs8SA1jpDiRp2urg@mail.gmail.com>
 <CABBYNZ+i1r=i_ihLb2Yocc4+3Bw7Py7ru8SwBweJeBp1jsicFg@mail.gmail.com>
 <CAHmfHqRKpY=0ot6htP=GdB3C=rHQn0jp-o6rvvYSpzKzeriePQ@mail.gmail.com> <CABBYNZ+JewnhDgsCdxhM9XT-9_Y7fRMMMhsaPgMdoNe0+Kka8A@mail.gmail.com>
From: Leon Nicholls <lnicholls@google.com>
Date: Sun, 1 Nov 2015 19:55:09 -0800
Message-ID: <CAHmfHqR9YUGtrRQcqiA9O9ySbbuR5DuCa3Bwt6=642F6WRiYpQ@mail.gmail.com>
Subject: Re: Cannot write to BLE thermal printer
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

My chromebook got a few more updates the past few days and now the
code is working and I can send characters to the printer! Thanks for
taking a look at the issue.

On Thu, Oct 29, 2015 at 11:53 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Leon,
>
> On Thu, Oct 29, 2015 at 5:02 AM, Leon Nicholls <lnicholls@google.com> wrote:
>> Following François instructions to explicitly stop the scan, here are
>> the latest logs. I'm getting a "GATT Error Unknown" in the browser,
>> although that might not be an error on the driver level but maybe just
>> due to a timeout on the browser level.
>
> I could only decode a Disconnect command from the btmon trace you
> sent, there is no ATT traffic at all.
>
> --
> Luiz Augusto von Dentz
