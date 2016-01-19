Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <75A0596B-E431-46F2-8906-E14839E46A57@gmail.com>
References: <75A0596B-E431-46F2-8906-E14839E46A57@gmail.com>
Date: Tue, 19 Jan 2016 14:33:03 -0800
Message-ID: <CAPyD+=AmV4ZeA4+kvyA4RiA_HkWKEir5MfXzt7R3AoPEvRhx5A@mail.gmail.com>
Subject: Re: Preferred way to set name of device?
From: "Othman, Ossama" <ossama.othman@intel.com>
To: Travis Griggs <travisgriggs@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Jan 19, 2016 at 11:39 AM, Travis Griggs <travisgriggs@gmail.com> wrote:
> I’m intersted in setting the name of my device, when I’m acting as a BLE Peripheral. I see at least two, maybe three, ways to do it:
>
> 1) Set the `Name=` line near the top of /etc/bluetooth/main.conf
> 2) Use hciconfig hc0 name FooBar
> 3) Maybe something with the dbus interface?
>
> So I’m curious which is the preferred/idiomatic way? In particular for my use case as a BLE Peripheral.
>
> I’ve discovered the following issues already:
>
> 1) If I use main.conf, that will be tricky, because I’d like to set the name based on dynamic information computed by the device in startup (serial number from an attached piece of equipment). So I’d have to modify the file after I have gotten that information, and then restart the service. Not undoable, but far from elegant.
> 2) Though hciconfig will show back the name set, it doesn’t seem to actually show up when I scan.
> 3) Not sure how I figure out what the dbus interface is. Is this documented anywhere? Or does one just explore and guess with tools? Maybe it’s too early in the experimental phase to really document?

I'm not sure of the preferred way, but I believe the D-Bus interface
you want is the "Alias" property in the org.bluez.Adapter1 interace:

http://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/adapter-api.txt#n119

HTH
-Ossama
