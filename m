Return-Path: <johan.hedberg@gmail.com>
Date: Mon, 25 Sep 2017 15:15:36 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Yunhan Wang <yunhanw@google.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] build: use abspath for lib/bluetooth
Message-ID: <20170925121536.GA30279@x1c>
References: <20170823225839.461-1-yunhanw@google.com>
 <D2A056DB-B533-4CAC-BCB8-19C39760E05F@holtmann.org>
 <CALvjcs-b3M9A6sdy80pakUwRHxBueuxpxvrpZt2SBhz=xDTK6g@mail.gmail.com>
 <CALvjcs-0POiT-inDdF8oxheHL=z6acK5E03QRtUwbHZnxcf37Q@mail.gmail.com>
 <CALvjcs8UK5Lik=CvU-vYzZ2=nrQh+BKy21isgs2Xh_yq4q9svA@mail.gmail.com>
 <CALvjcs8rzxTCLP72GoiCmEBw7H=rDzreP+c_NytL-2weCRXT6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CALvjcs8rzxTCLP72GoiCmEBw7H=rDzreP+c_NytL-2weCRXT6Q@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Yunhan,

On Sun, Sep 24, 2017, Yunhan Wang wrote:
> Can anyone take a further review?

I think Marcel is still waiting for confirmation that this works with
fakeroot (at least I didn't see that you would have confirmed it). I
tried that myself just now and seems to work fine, so no objections from
me for merging.

Johan
