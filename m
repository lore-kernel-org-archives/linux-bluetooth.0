Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAB7rCTg4YLsE7uNbR8mRH_cubtMmBnTZUnJ3U4vL_AsyjA7xzA@mail.gmail.com>
References: <CAB7rCTg4YLsE7uNbR8mRH_cubtMmBnTZUnJ3U4vL_AsyjA7xzA@mail.gmail.com>
Date: Mon, 19 Mar 2012 17:36:06 -0500
Message-ID: <CAB7rCTgRrgv-FXVU2xcxwi-aQjMT5KmkbLahVTYKSrHhcAkGpQ@mail.gmail.com>
Subject: Re: reverse SDP issue
From: Mike <puffy.taco@gmail.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Mar 19, 2012 at 5:19 PM, Mike <puffy.taco@gmail.com> wrote:
>
> There may be another subtle bug that is the real culprit here (e.g.,
> why does removing 0x110d knock out the other profiles), but I thought
> I'd check on this first.
>

Ah, I can see that Mikel Astiz's patches (from inspection) should
solve this part of the problem:

[PATCH v0 2/3] Add device driver support for partial unloading
http://www.spinics.net/lists/linux-bluetooth/msg22427.html

[PATCH v0 3/3] audio: add partial unloading to audio driver
http://www.spinics.net/lists/linux-bluetooth/msg22428.html
