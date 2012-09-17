Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLsZRofkV5DDEj84dzzptUhx5YjCzoyk9UyjRJYU16Y5w@mail.gmail.com>
References: <1346378760.7976.2.camel@obelisk.thedillows.org>
	<20120907124559.GA16092@x220>
	<CABBYNZ+5E+BC-+9fj0e7iUpEDFJrJBQo8aoMZj8ZEkmiuB=QLA@mail.gmail.com>
	<1347284864.3532.1.camel@sirocco.hadess.net>
	<CABBYNZJpHkt8CGDsfVwirZ=vecb-fhbpPbrVFKt1UR_rA25mSw@mail.gmail.com>
	<CABBYNZ+n9obON7iNcv66x2ZVQCeTs_JoJUDXZFwxJJ6C4cb4YQ@mail.gmail.com>
	<CABBYNZKggzJ7bzQWVmWi30kxOUR8bVCyMLL=SM1=Oe74YPwvKg@mail.gmail.com>
	<1347394656.1606.10.camel@sirocco.hadess.net>
	<CABBYNZ+gpheC9sNeTp2uvDFBV-yPs+cY4PUR2omPt_kLTCafKw@mail.gmail.com>
	<1347456657.23874.29.camel@sirocco.hadess.net>
	<CABBYNZLwXhF0gixPGKUTJY4sZ7EHynTYmHzGtiZsoRGXgeEFaw@mail.gmail.com>
	<CANq1E4SDXVHcumBbEA-4xpeuOQ0SjDxxtL_RqAiNYRPj6ccagQ@mail.gmail.com>
	<20120913003628.ce5babb2a66d09fe17fa15de@studenti.unina.it>
	<1347591892.6145.14.camel@obelisk.thedillows.org>
	<20120917120441.a164d2e10bb02aa9a1e8d523@studenti.unina.it>
	<CABBYNZLsZRofkV5DDEj84dzzptUhx5YjCzoyk9UyjRJYU16Y5w@mail.gmail.com>
Date: Mon, 17 Sep 2012 12:52:06 +0200
Message-ID: <CANq1E4RPw4QyRZWaCnB5H6pE5KuVxgaUvF3y26dr9j6MfiJf1Q@mail.gmail.com>
Subject: Re: [KERNEL PATCH] HID: Add support for Sony BD Remote
From: David Herrmann <dh.herrmann@googlemail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Antonio Ospite <ospite@studenti.unina.it>,
	David Dillow <dave@thedillows.org>,
	linux-bluetooth@vger.kernel.org, Bastien Nocera <hadess@hadess.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz

On Mon, Sep 17, 2012 at 12:46 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> HI Antonio,
>>
>> Reviewed-by: Antonio Ospite <ospite@studenti.unina.it>
>>
>> I just did a syntax/style review, maybe I will take another look at the
>> actual logic in the future to see if the report decoding procedure can
>> be improved but for now I think it's OK, we want to have this driver in
>> ASAP.
>>
>> David D. please bring up again the issue about missing keypresses on
>> re-connection when sending the driver to linux-input with a full
>> description of what you observed, I don't have a clue about these
>> matters but people on linux-input might.
>
> I now have the remote, I tried using xinput test and most keys seems
> to be working fine except the special buttons like subtitle, colors,
> x, l1... Im not sure if they are not being mapped because they don't
> have any representation or there is something wrong in the parser
> itself (Bastien do they used to work for you?). Also got a problem on
> suspend but I will have to reproduce it again to see if it is because
> of the new driver or not.

For debugging of input devices I recommend:
http://cgit.freedesktop.org/evtest/tree/evtest.c

Simply run it as ./evtest /dev/input/eventX
And it shows you all events that are sent. You can use it to see
whether the special-buttons are actually handled by the kernel.

The suspend problems are Bluetooth-related. We never actually got that
right. It's always the HIDP code that fails somewhere.

Regards
David
