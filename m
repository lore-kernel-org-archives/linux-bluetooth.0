Return-Path: <cyrus@holtmann.org>
From: "Gunn, Brian" <bgunn@solekai.com>
To: Ronny Pau <ronnypau@gmail.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Fri, 16 Apr 2010 10:27:04 -0700
Subject: RE: what is needed for SSP mode
Message-ID: <FE57175CCE23E5419899C1B0CFA26FAD13F022D7B5@EXMBXSD.dm.solekai.com>
References: <p2ld6c61fb91004151917x2a93d5dfr2ef1e6c2d01819a0@mail.gmail.com>
In-Reply-To: <p2ld6c61fb91004151917x2a93d5dfr2ef1e6c2d01819a0@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> Now, I would like to switch on SSP mode, where I have issued
> "hciconfig hci0 sppmode 1" and verify that it is indeed on using
> "hciconfig hci0 sppmode".  However, if I attempt to connect with my
> cellphone, I get a connection failure. Have I missed something?

I've tried too and have the same problem with SSP mode.  I think it may work with "NoInputNoOutput" mode, but I couldn't get "DisplayYesNo" to work with a 6 digit decimal number.

(Then again, I am not using the very latest release, though I didn't see any changes to SSP lately.)

Brian

