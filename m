Return-Path: <cyrus@holtmann.org>
Message-ID: <1335552700.16897.477.camel@aeonflux>
Subject: Re: hcidump / avtest issues
From: Marcel Holtmann <marcel@holtmann.org>
To: Mike <puffy.taco@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Fri, 27 Apr 2012 20:51:40 +0200
In-Reply-To: <CAB7rCTgK1eZwHQVp-VXxzWH_CmE_uygvcJ2HMJfZSTdE_LGiSw@mail.gmail.com>
References: <CAB7rCTgK1eZwHQVp-VXxzWH_CmE_uygvcJ2HMJfZSTdE_LGiSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mike,

> I'm having issues where hcidump seems to be losing packets.  I'm
> trying to collect traces of avtest running.  Avtest properly prints
> out that it sent a packet and received a reply, but I don't always see
> it in hcidump.  Seems if I run avtest a lot successively, it does show
> up.  I'm running a 2.6.33.20 kernel with hcidump-2.3.  Let me know if
> the kernel is just too ancient, but I'd like to know if others have
> seen this type of issue.

actually hcidump can not loose any packets. Write them into a file in
BTSnoop format and double check with Wireshark or the Frontline Viewer.

The kernel is always sending the exact copy to the hcidump sockets and
thus there is no way you loose packets. The only explanation would be
that L2CAP socket has a bug and swallows it. Have you checked that
avtest actually reports L2CAP send errors.

Regards

Marcel


