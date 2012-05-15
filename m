Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJwOvn48nx7y=T=64A+8MnmxS2vdVD+3A9TK7v89T2wHQ@mail.gmail.com>
References: <1337009584-17181-1-git-send-email-mikel.astiz.oss@gmail.com>
	<CABBYNZKyPPb=Ov+6p6-9PUY6nrBTD1M_Ew9YeF_cxt8OQ5x85Q@mail.gmail.com>
	<CANT-zCU-CTWq-9ZR+YQQfuQWKHnxut_dXBA1Cpna9vTJvO5J9w@mail.gmail.com>
	<CABBYNZJwOvn48nx7y=T=64A+8MnmxS2vdVD+3A9TK7v89T2wHQ@mail.gmail.com>
Date: Tue, 15 May 2012 10:45:05 +0200
Message-ID: <CANT-zCXBoa+SsSqrMahPFumww65GaNVyYKCWefZK-a+pzS+RXg@mail.gmail.com>
Subject: Re: [RFC BlueZ v0 0/5] ACL disconnect reason
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> So if it is recommended by the white paper I don't see why it should
> be manufacture/model specific, note that only the number of attempts
> to re-connect is implementation dependent, but we can have an option
> in audio.conf where the platform configure the number of attempts and
> perhaps the interval between them if we cannot find a good default.

We might be discussing about different reconnection policies. You are
focusing on the short-term reconnection strategy, where several
attempts can be made in order to reconnect as soon as possible and
improve user experience. For this I agree BlueZ could handle the case.

However this RFC was motivated by the overall connection policy
(perhaps "reconnect" was not the right term here). A use-case can be a
car with a paired phone and HFP is connected. The user leaves the car
while still turned on (someone else could be driving) and a timeout
would eventually occur. Next morning, when the user enters the car,
his phone should be connected. On the contrary, if the user
disconnected the HFP from the phone, this reconnection should not be
triggered.

>From my point of view, the exact policy of which devices, how many of
them, using which priorities, which profiles, etc. is manufacturer and
model-specific. I don't think these policies should be embedded in
BlueZ. After all, we already have a nice D-Bus API to handle these
use-cases, and only the disconnect reason seems to be missing.

Cheers,
Mikel
