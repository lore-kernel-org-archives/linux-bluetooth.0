Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5662D1DF.4000601@att.net>
References: <5662D1DF.4000601@att.net>
Date: Mon, 7 Dec 2015 16:24:40 +0200
Message-ID: <CABBYNZ+ZtsMcnq2gaGcBeqcAXOCtwsRh9+wC0Y3qv_OV8XL8gA@mail.gmail.com>
Subject: Re: bluez iphone connection
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Steve Abner <pheonix.sja@att.net>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steve,

On Sat, Dec 5, 2015 at 2:00 PM, Steve Abner <pheonix.sja@att.net> wrote:
> Hi, I'm end user on both ubuntu 15.10, and LFS with kdbus,systemd-227,4.2
> kernel.
> I've connected both systems to iphone, but with big song and dance. First
> connected
> to ubuntu, worked. Boot into LFS, use bluetoothctl, finally get it to
> connect.  Go back to
> ubuntu, must delete, use bluetoothctl remove, start process over, finally
> get connected.
> Boot LFS, cp over "info" as have done with trackpad. This cp is only work
> around I've found
> so that you dont have to reset and start from scratch when rebooting. But I
> didn't
> try to remove iphone and restart whole 30 min connection process on LFS. Go
> back
> to ubuntu and it just refuses to connect, did not request new pairing on
> purpose, that's why
> didn't attempt dance on LFS.

What kind of setup is this, can you use a different adapter per
system, Bluetooth pair work in relation to the adapter address so the
iPhone has no idea you are switching between systems.

>   Both systems I get:
> Bluetooth: Unexpected continuation frame (len 0)
> connect error: Too many levels of symbolic links (40)

Im afraid there is something wrong which the way you copy pairing
details from one system to the other, anyway it is probably not
recommended to do that in the first place.

>   Honestly forget which applies to connection from pc to phone, vs. phone to
> pc.
> If someone could direct me to documentation, which I cant find through web
> searching,
> or answer this, I'd be thankful. Hopefully, an automated process for end
> users to simply connect to devices, would be nice.

There is plenty of example on how to pair, gnome has done that if you
need a graphical interface and bluetoothctl is also capable of doing
it, but Im afraid the problem with your setup so I suggest you use a
different adapter per system if possible or mount the same partition
in the place of /var/lib/bluetooth so the system are synchronized when
you reboot/

>   Apologies if wrong list, but only one that I found on bluetooth, linux.
> Steve
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
