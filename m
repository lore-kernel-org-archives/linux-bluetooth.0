Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH/RFC] SIMD optimizations for SBC encoder analysis filter
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Siarhei Siamashka <siarhei.siamashka@nokia.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <2d5a2c100812311255p2d10b74crc31ff3211ca1939d@mail.gmail.com>
References: <200812311803.45279.siarhei.siamashka@nokia.com>
	 <2d5a2c100812311255p2d10b74crc31ff3211ca1939d@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 06 Jan 2009 03:50:26 +0100
Message-Id: <1231210226.13304.17.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> I wonder why don't we use liboil
> (http://liboil.freedesktop.org/wiki/). Since we can't keep
> implementing, or don't want to, optimization code for each instruction
> extension around. Liboil detects which implementation is faster at
> runtime and there are many other codec implementations that depend on
> it, it actually makes a lot of sense to gstream and PulseAudio which
> already uses liboil. I know that means adding another dependency to
> BlueZ, or perhaps it is time to make libsbc a real library?

let me stop the discussion about liboil right now. I don't see any big
advantage for BlueZ right now. This might change at some point in the
future, but right now, we will not base around liboil.

Regards

Marcel


