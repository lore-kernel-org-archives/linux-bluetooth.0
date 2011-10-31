Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 31 Oct 2011 20:11:22 -0300
Message-ID: <CAKT1EBevp9_bygG8UNO6fj-nU8_C3HDfjOQBRrhMqJij103tBw@mail.gmail.com>
Subject: Multiple instances of same characteristics (was: Re: GATT Dbus API on
 BlueZ - attirbute-api.txt modifications)
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: "Tsai, Mike" <miketsai@qca.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mike,

> [MT]How can this handle the multiple instances of same characteristics within a single service? The characteristic UUID will not be unique in that case. Also, how is the profile specific characteristic descriptor handled?
>
> Cheers,
>
> Mike

I am moving your question to another thread. The original thread is
almost impossible to follow.
Do you mean support for client characteristic configuration and other
characteristics per device?

In the Generic Attribute API(client), the represented characteristics
are always per device. The abstraction for per device characteristic
value needs to implemented in the server.
The current attribute server supports CCC only, before implementing
per device characteristics we need to cleanup the code.

BR,
Claudio.
