Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAEZxfGPdU0fzp_P-7AJDSF+xCnXPqVUHs8fs8SA1jpDiRp2urg@mail.gmail.com>
References: <CAHmfHqTrHGpwyxaP6rsBNk5FamFxJMFBy547UY21vQLdLSDc4Q@mail.gmail.com>
	<CABBYNZLjPt_vCcW5JswbK+utJvVm8SbEAus7dw0jt+fW3Q8Fug@mail.gmail.com>
	<CAHmfHqQjBKrW+HhjDLaNQPcvYwnzYtm=2WJUhAgKUyyAS-AW7A@mail.gmail.com>
	<CABBYNZJbZzuFQNYSmMmXNv3zWPBsvtFSTvFKroCyyQndDPrw7Q@mail.gmail.com>
	<CAHmfHqS_jW0vLA14wMz939BNV1XKzUr7BG+_h_4Xzq1LywLz+w@mail.gmail.com>
	<CAEZxfGPPoYOX=yGDP2TQFRw7GY_zCXZrPYuDxxK8jt49veyjyg@mail.gmail.com>
	<CAHmfHqQLmiGep3nKZ-Vq8RHqvG-SwVJhvUJSnDJZ6+jGeAFXpg@mail.gmail.com>
	<CAEZxfGPdU0fzp_P-7AJDSF+xCnXPqVUHs8fs8SA1jpDiRp2urg@mail.gmail.com>
Date: Wed, 28 Oct 2015 10:00:34 +0200
Message-ID: <CABBYNZ+i1r=i_ihLb2Yocc4+3Bw7Py7ru8SwBweJeBp1jsicFg@mail.gmail.com>
Subject: Re: Cannot write to BLE thermal printer
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Cc: Leon Nicholls <lnicholls@google.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi François

On Wed, Oct 28, 2015 at 7:45 AM, François Beaufort
<beaufort.francois@gmail.com> wrote:
> Does it work on Android or iOS?
> If so, could you provide a trace?
>
> On Wed, Oct 28, 2015 at 6:43 AM, Leon Nicholls <lnicholls@google.com> wrote:
>> I'm still getting a GATT error.

It would be nice to know what error you are talking about, note that
in the previous trace you sent there was actually no error because the
scan is blocking any other communication to happen ATT eventually
timeout (ATT timeout is 30 seconds) which cause the ACL to be
disconnected.

-- 
Luiz Augusto von Dentz
