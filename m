Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAGGi21ZDsS0__YnzWqWfcmk=jSAEZYQwUD8Dx2c8fi25bWn5SA@mail.gmail.com>
References: <CAGGi21YVrRB06R8ahxRLBZ=xZkNKGnCsetL1xUQx9DPLeAGGXA@mail.gmail.com>
 <CABBYNZKi=TSWQxyN6j1=a++V5p-e8viB=qWxnX1pGQShz9A-YA@mail.gmail.com>
 <10452927.a6KM84WJTg@leonov> <CAGGi21ZDsS0__YnzWqWfcmk=jSAEZYQwUD8Dx2c8fi25bWn5SA@mail.gmail.com>
From: Elliot Saba <staticfloat@gmail.com>
Date: Mon, 14 Sep 2015 20:32:34 -0700
Message-ID: <CAGGi21aF8ipUcH0wUWaJGGS4DmDtQJWOPqcyB0zyK3uF93JN4g@mail.gmail.com>
Subject: Re: Understanding connecting to BLE keyboard
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello all, thank you for your responses so far.

First off, I had not tried entering the PIN, because nothing had
prompted me to do so.  I have intermittently managed to get a PIN
prompt to show up in bluetoothctl now that I am using "agent
KeyboardDisplay" instead of "agent KeyboardOnly", thanks to Szymon's
advice.  However, although it now sometimes prompts me for a PIN code,
other times it doesn't, and I still get "authentication canceled"
errors extremely quickly (less than a second) after attempting to
pair.  Here is an example session, with both bluetoothctl and btmon
output: https://gist.github.com/staticfloat/bbc016376ba5a8ab4451

Secondly, what manual do you refer to?  I am having a difficult time
finding bluez documentation, so if there is a bluez manual somewhere,
I'd love to read it.  If you refer to the manual for my keyboard,
sadly its manual says nothing about Linux.  I can pair it on other
operating systems such as OSX without difficulty (and yes, it requires
entry of a PIN) so I am confident I know the proper method to pair it
with a device.

Thanks!
-E
