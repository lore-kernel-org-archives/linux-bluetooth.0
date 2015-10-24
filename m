Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: Get the raw Bluetooth Low Energy advertising data
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHugcUdZEwb1J8ephG9Nxk61UzTU-wbtArjcvj4tyU_jeSUbOA@mail.gmail.com>
Date: Sat, 24 Oct 2015 12:01:12 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <12F1F411-4B0A-434F-936C-956359252B7F@holtmann.org>
References: <CAHugcUdZEwb1J8ephG9Nxk61UzTU-wbtArjcvj4tyU_jeSUbOA@mail.gmail.com>
To: eroot <eigenroot@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> I am trying to get raw BLE advertising information using Bluez tool
> such as hcitool in a quick and dirty way. Someone (in this post
> http://comments.gmane.org/gmane.linux.bluez.kernel/43422) modified the
> "print_advertising_devices" function in "tools/hcitool.c", and he
> claimed successfully printing out the advertising data from command
> "sudo hcitool lescan". The "hcitool.c" can be conveniently viewed here
> http://git.kernel.org/cgit/bluetooth/bluez.git/tree/tools/hcitool.c .
> I guess the pointer "info" with type of "le_advertising_info" (defined
> in "lib/hci.h") in  "print_advertising_devices" function has all
> advertising information . A closer look into the struct definition
> 
> typedef struct {
> uint8_t evt_type;
> uint8_t bdaddr_type;
> bdaddr_t bdaddr;
> uint8_t length;
> uint8_t data[0];
> } __attribute__ ((packed)) le_advertising_info;
> 
> reveals that the data array has zero length. In that case, where is
> the advertising data?

you might need to brush up your knowledge about what zero length data fields mean in a C struct ;)

However I would not advice in doing such a quick and dirty hack. The D-Bus API gives full access to advertising data in the latest version. So you should really use that. Trying to get LE Advertising Report HCI events parsed correctly is harder than you think. So unless you really grok the Bluetooth Core specification, I would not go there.

Regards

Marcel

