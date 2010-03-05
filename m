Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <2a9506371003020914q3786eb70k57f5b1adda62c05@mail.gmail.com>
References: <aa6ee971003020826m7e6db9b2jd5b9456a1aa1d368@mail.gmail.com>
	 <2a9506371003020914q3786eb70k57f5b1adda62c05@mail.gmail.com>
Date: Fri, 5 Mar 2010 10:52:25 +0000
Message-ID: <aa6ee971003050252i23709c44l585bd6a9851d0936@mail.gmail.com>
Subject: Re: Bluetooth SPP on Nokia N900 (Maemo 5)
From: Henry Owens <owens.henry@googlemail.com>
To: Vinicius Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Vinicius,

Many thanks for your help - I used the example script, and it is now
connecting correctly to my device.

I am having a slight issue, however, with the fact that the
"SetSerialParameters" method is experimental, and thus I can not use
it - could anyone point me to where I can set the parameters correctly
so that it can receive packets from the device?

FYI, the device is simplex - it sends a packet once per second, and
ignores any commands, so I simply want to receive the packets and
parse them.

At present, when I use the code below, I do not get any output, which
I assume is because my serial settings are incorrect.

Many thanks again for your help,
Henry.

test.py:

import sys
import dbus

bus = dbus.SystemBus()

manager = dbus.Interface(bus.get_object("org.bluez", "/"),
						"org.bluez.Manager")

adapter = dbus.Interface(bus.get_object("org.bluez", manager.DefaultAdapter()),
							"org.bluez.Adapter")

address = "00:07:80:88:F4:E9"
service = "spp"

path = adapter.FindDevice(address)

serial = dbus.Interface(bus.get_object("org.bluez", path),
						"org.bluez.Serial")

node = serial.Connect(service)

print "Connected %s to %s" % (node, address)

print "Press CTRL-C to disconnect"

a = open("/dev/rfcomm0","r")

w = a.readline()

print w

serial.Disconnect(node)



On Tue, Mar 2, 2010 at 5:14 PM, Vinicius Gomes
<vinicius.gomes@openbossa.org> wrote:
> Hi Henry,
>
> On Tue, Mar 2, 2010 at 1:26 PM, Henry Owens <owens.henry@googlemail.com> wrote:
>> Hi All,
>>
>> My first mail to this list. I am currently trying to get a bluetooth
>> SPP connection going on my Nokia N900, but I'm having some
>> difficulties using the examples on the HOWTO Wiki.
>>
>> Specifically, I get an error related to the ActivateService call in
>> the example - I have seen reference to this being obselete in Bluez
>> 4.x, is this the problem in the example code?
>>
>
> Yeah, the example code in the wiki is outdated, take a look at the
> example in the sources [1],
> for a working one.
>
> Also, in that same directory there are a few more examples that could be useful.
>
>
> Cheers,
> --
> Vinicius Gomes
> INdT - Instituto Nokia de Tecnologia
>
> [1] http://git.kernel.org/?p=bluetooth/bluez.git;a=blob;f=test/test-serial;hb=HEAD
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
