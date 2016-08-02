Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Tue, 2 Aug 2016 10:53:48 +0200 (CEST)
From: Serge van den Boom <serge@vdboom.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Registering profile or making discoverable resets adapter
 class
In-Reply-To: <CABBYNZ+jy2gikskaA6rX+ha2nbWn23TNY7dyFQehjFa3bF-_Rg@mail.gmail.com>
Message-ID: <alpine.BSF.2.00.1608021015420.32248@toad.stack.nl>
References: <alpine.BSF.2.00.1608011427420.69212@toad.stack.nl> <CABBYNZJMMSrgRO8EsZ78yOv0R5cwfpz65EQ+-zSV67mX2ee4Dw@mail.gmail.com> <alpine.BSF.2.00.1608011632330.96508@toad.stack.nl> <CABBYNZ+jy2gikskaA6rX+ha2nbWn23TNY7dyFQehjFa3bF-_Rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, 1 Aug 2016, Luiz Augusto von Dentz wrote:

> On Mon, Aug 1, 2016 at 7:12 PM, Serge van den Boom <serge@vdboom.org> wrote:
> > I haven't been able to find the part of the bluetoothd code that you are
> > referring to, so far. I would appreciate it if you could point me in the
> > right direction.
> 
> https://git.kernel.org/cgit/bluetooth/bluez.git/tree/src/adapter.c
> (get_uuid_mask)

I see. So this only affects the major service class part of the
CoD field, and not the (major or minor) device class parts.
And as there is no case for HID_SVCLASS_ID, the CoD is not affected by
an HID service.

> For more about registering profiles see:
> https://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/profile-api.txt
> 
> You may not be able to register HID as an external profile if the
> input plugin is active because afaik both roles have to listen to
> certain fixed PSMs, I wouldn't oppose to have this functionally in the
> input plugin itself though since we can make it generic enough to use
> with HoG implementation.

I had my service working already, but it involved setting the class id
in the /etc/bluetooth/main.conf file. I disliked this, as it involved
making a system-wide modification to run my service.

After a conversation on the #bluez IRC channel, it appears that this
however is the correct way. Apparently, a bluetooth device is not
expected to change what it is.

I did indeed have to disable the input plugin.


Thanks,

Serge

