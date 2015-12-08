Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Steve Abner <pheonix.sja@att.net>
Subject: Re: bluez iphone connection
To: linux-bluetooth@vger.kernel.org
References: <5662D1DF.4000601@att.net>
 <CABBYNZ+ZtsMcnq2gaGcBeqcAXOCtwsRh9+wC0Y3qv_OV8XL8gA@mail.gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Message-ID: <56664C25.8040308@att.net>
Date: Mon, 7 Dec 2015 22:19:01 -0500
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+ZtsMcnq2gaGcBeqcAXOCtwsRh9+wC0Y3qv_OV8XL8gA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



On 12/07/2015 09:24 AM, Luiz Augusto von Dentz wrote:
> What kind of setup is this, can you use a different adapter per
> system, Bluetooth pair work in relation to the adapter address so the
> iPhone has no idea you are switching between systems.
One computer, two operating systems, one common controller. I really like
the idea that the phone or trackpad shouldn't care about switching systems.
Problem I have is Bluez has to set pairing, not user, so one system sets 
with
pin of xxxx, other with yyyy, device seems to say machine A, so I'll except
pin xxxx, but not yyyy. So copy xxxx to replace yyyy. If bluez asked for pin
then could tell it instead of copy it, but copy easier then remembering 
hundreds
of pins.
>> >   Both systems I get:
>> >Bluetooth: Unexpected continuation frame (len 0)
>> >connect error: Too many levels of symbolic links (40)
> Im afraid there is something wrong which the way you copy pairing
> details from one system to the other, anyway it is probably not
> recommended to do that in the first place.
This only occurs with iphone, not a trackpad. So copying the pin should
not be an issue. The pin is encoded, don't know by which crypto method.
Plus, one way, phone to pc works, pc to phone doesn't.
>> >   Honestly forget which applies to connection from pc to phone, vs. phone to
>> >pc.
>> >If someone could direct me to documentation, which I cant find through web
>> >searching,
>> >or answer this, I'd be thankful. Hopefully, an automated process for end
>> >users to simply connect to devices, would be nice.
> There is plenty of example on how to pair, gnome has done that if you
> need a graphical interface and bluetoothctl is also capable of doing
> it, but Im afraid the problem with your setup so I suggest you use a
> different adapter per system if possible or mount the same partition
> in the place of /var/lib/bluetooth so the system are synchronized when
> you reboot/
   ArchLinux normally has most info, debian not too bad, one guy's 
article helped me
to create a systemd service, based on his BT keyboard issues.
   And I don't see why one controller must be dedicated per OS.
   Binding to one partition, not an option. When LFS moves to another 
machine
it will never see that partition. At which time it will be a different 
controller, but I am
not at that development stage. I assume same hostname, yet different 
controller will
provide a new connection slot on phone, thereby not creating an issue of 
pins. This
would be a different /var/lib/bluetooth/<controller>/<same.MAC>/info.

But all said, this points to bluez. I haven't even asked about its other 
issues.
Both systems:
    Failed to obtain handles for "Service Changed" characteristic
One with multiple:
    Not enough free handles to register service

Was just working out connecting. I have gotten it to where I can switch 
between OSes
and connect by phone issuing the connect command. Both are accompanied by:

Bluetooth: Unexpected continuation frame (len 0)

The ubuntu can issue, through graphical means (and NetworkManager), 
connection.
The LFS system, no graphical yet, just fb/gpu terminal, can not issue 
connection.
Bluetoothctl has the "info", trusted, paired, etc, but refuses to 
connect. I have connected
by "remove", restart phone and computer, issue new pin. Of course the 
means that ubuntu
will no longer work until I re-pair, new pin, which without the copy 
means I must, remove,
reboot, re-pair the LFS, and around I go.
   Now if someone knows exact sequence of connection of a paired device 
using either
hcitool or bluetoothctl this would be helpful. I've tried agent on, 
pairable on, discoverable on,
pair <mac>, (already paired it complains), connect <mac>, different 
sequences of those
commands.
   Some is new, just added in sound today (so not researched yet):
bluetoothd[269]: a2dp-source profile connect failed for 
70:3E:AC:50:D8:89: Protocol not available
kernel: Bluetooth: Unexpected continuation frame (len 0)
bluetoothd[269]: Can't open input device: No such file or directory (2)
bluetoothd[269]: AVRCP: failed to init uinput for 70:3E:AC:50:D8:89
bluetoothd[269]: Invalid folder length
   I am by no means an expert, but logically and process of elimination 
don't point
to pin, nor the concept of one controller per OS, thou broadcom might 
like that idea.
A missing module, a support library maybe?
Steve
