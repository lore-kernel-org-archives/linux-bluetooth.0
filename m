Return-Path: <cyrus@holtmann.org>
From: Denis Kenzior <denkenz@gmail.com>
To: "linux-bluetooth" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC] HFP support into oFono and BlueZ
Date: Sun, 17 Jan 2010 16:37:21 -0600
References: <fbf08281001110908s2c3412m456b3aa980b8ca10@mail.gmail.com> <fbf08281001131539l342a3062w70883c197dc52983@mail.gmail.com> <2d5a2c101001180338n2a37f0e9y76942650b755166@mail.gmail.com>
In-Reply-To: <2d5a2c101001180338n2a37f0e9y76942650b755166@mail.gmail.com>
Cc: ofono@ofono.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201001171637.22263.denkenz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> having it as a MediaEndpoint I guess it is probably a good idea to
> have a similar design as we will have in endpoints, so the
> registration actually happen in adapter path rather than device path,
> which probably should avoid the having to resolve the device path
> while probing if we just send the device path as a parameter of
> NewConnection so we can do while in DEFER_SETUP stage so we don't risk
> missing or getting timeouts while transferring the the fd to ofono.

Personally I like this to be a per-device agent rather than per-adapter as it 
will make agent code inside oFono a bit easier to write.  Marcel / Johan, care 
to weigh in?

Regards,
-Denis
