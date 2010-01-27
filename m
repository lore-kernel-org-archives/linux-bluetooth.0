Return-Path: <cyrus@holtmann.org>
Subject: Re: bluetoothd bug
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	Johan Hedberg <johan.hedberg@nokia.com>,
	luiz.dentz-von@nokia.com,
	BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <2d5a2c101001270021m54f3e905rfeac8c2b8bc8156f@mail.gmail.com>
References: <f9d4bd31001251014w1caaa753v39254c3031f5db0e@mail.gmail.com>
	 <2d5a2c101001260309h4464805eg3e52ace6dd28f677@mail.gmail.com>
	 <f9d4bd31001261033g2d23a089r21069797fea38d9b@mail.gmail.com>
	 <2d5a2c101001270021m54f3e905rfeac8c2b8bc8156f@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 27 Jan 2010 09:43:30 +0100
Message-ID: <1264581810.3227.1.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> Great, not sure how PTS was able to trigger it since it seems to be
> passing bonding phase without resetting temporary flag which would
> mean bonding fails and would not even schedule the reversal service
> discovery, but a segfault is always a bug no matter what stupid things
> PTS is doing.

as I explained to Claudio, the PTS guys didn't even read their own
specification. With Simple Pairing you are required to establish the
encryption for everything except PSM 1. And the kernel will reject
everything that tries to establish a L2CAP channel before encryption is
in place.

Regards

Marcel


