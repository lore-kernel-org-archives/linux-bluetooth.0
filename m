Return-Path: <cyrus@holtmann.org>
In-Reply-To: <CANq1E4RYuVy2b1GD2E4MsErbkGZgD6gnDaYeDmyWyYnKaze0Jg@mail.gmail.com>
References: <5050F5A9.5090401@butterbrot.org> <CANq1E4RYuVy2b1GD2E4MsErbkGZgD6gnDaYeDmyWyYnKaze0Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: Wii Balance Board vs. bluez
From: Florian Echtler <floe@butterbrot.org>
Date: Thu, 13 Sep 2012 07:59:11 +0200
To: David Herrmann <dh.herrmann@googlemail.com>
CC: linux-bluetooth@vger.kernel.org
Message-ID: <ed6fbaf1-1410-4539-a36e-1d6d6f6220b5@email.android.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



David Herrmann <dh.herrmann@googlemail.com> wrote:

>"backported"? Why would you backport the hid-wiimote driver? Or do you
>mean "forwardport"? Anyway, the hid-wiimote driver does not have
>support for the wii-balance board as I do not have access to them.
By "backport", I just meant that I recompiled the driver from 3.5 for my 3.2 kernel :-)

>However, if you are willing to test it, I will send some patches which
>will implement it.
Absolutely, I'd be happy to test.

>Ouh, I see. I will send a patch fixing this to the BlueZ mailing list.
>I will put you on CC if you don't mind.
Thanks, I'll test this later today.

One additional question: it looks like this problem with the pairing is going
to pop up again with 3rd-party controllers, the new Wii U controller etc. 
Would it make sense to create a new PIN option which users can select 
explicitly? 

Florian
-- 
SENT FROM MY PDP-11
