Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMk70DBgaYSK5bMLPUR1c7Gf1xFO8px4fgtqqnQ1-qMXUOq3PA@mail.gmail.com>
References: <CAMk70DBgaYSK5bMLPUR1c7Gf1xFO8px4fgtqqnQ1-qMXUOq3PA@mail.gmail.com>
Date: Fri, 15 Jun 2012 00:24:18 -0300
Message-ID: <CAFsbExJZd6w4-o4YZ82oeVLdRDr-tWhrNwN+zQv2WbJb6cKqUg@mail.gmail.com>
Subject: Re: Question For Devs: Is Headset Connection Automatic?
From: Gustavo Padovan <gustavo@padovan.org>
To: bubba junk <junkbubba2@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bubba,

On Thu, Jun 14, 2012 at 6:31 PM, bubba junk <junkbubba2@gmail.com> wrote:
> I am non-developer with a basic question about basic BlueZ
> functionality. I have a BT headset (Samsung HM1000) that I have paired
> with BlueZ. I am able to successfully connect / disconnect the headset
> using the bluetooth panel applet (in Ubuntu 12.04 lastest patches). My
> question is should the headset automatically connect to BlueZ after it
> is powered on or after pressing the talk button?
>
> My BT Logitech mouse automatically connects to BlueZ after it has been
> powered on or after a long period of inactivity. I expected the
> headset to do the same, connect automatically. Is there a way to have
> the headset connect automatically without having to select 'Connect'
> from the panel applet?

It is supposed to connect automatically. Can you provide a hcidump
(usually bluez-hcidump package) of a connection attempt from the
headset. Also run the test list-devices script (present in bluez
sources under the test dir) and tell us the result.

Gustavo
