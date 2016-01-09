Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <60A6FB99-38F5-4591-88B5-368DFC659FB4@gmail.com>
References: <1450426763-17753-1-git-send-email-gowtham.ab@samsung.com>
	<38CECA18-9BB8-4480-BA0F-027B87AB7A85@gmail.com>
	<CADLK-zEQH4LiXZwwUUdj4FTqmJhm4-m7vhadR5q2XEQ66OUg7g@mail.gmail.com>
	<60A6FB99-38F5-4591-88B5-368DFC659FB4@gmail.com>
Date: Sat, 9 Jan 2016 08:03:18 +0000
Message-ID: <CAAu3APZ2q5Pabb0G2qjWHm9sQvJLON3oqgP9YNiHYED1cYQH2g@mail.gmail.com>
Subject: Re: Strange python behavior, I think (was: ARM SBC as a BLE Peripheral)
From: Barry Byford <31baz66@gmail.com>
To: Travis Griggs <travisgriggs@gmail.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Travis,

On 8 January 2016 at 21:37, Travis Griggs <travisgriggs@gmail.com> wrote:
>
>> On Dec 18, 2015, at 9:22 AM, Gowtham Anandha Babu <gowbabuar@gmail.com> wrote:
>>
>> Hi Travis,
>>
>> On 18 December 2015 at 21:51, Travis Griggs <travisgriggs@gmail.com> wrote:
>>>
>>> I hope this question isn’t completely out of order here… I’ve been lurking for a week or so, and it seems the list is mostly patch submission/discussion.
>>>
>>> I’m working with a small Linux ARM SBC (similar to a Raspberry Pi), trying to set it up as a BLE peripheral. I’m running Debian Jessie, and build 5.36 of the bluez stack.
>>>
>>> I’m relatively new to the bluez stack. I’ve been able to follow some SO posts and such to poke a couple of hciconfig commands to get my device advertising so that I can scan it with a phone app, and even changed its advertised name by tweaking one of the bluetoothd .conf files. But getting past that, I’m not sure really where to go. I want to set up a single service and characteristic with notify/write so that I can communicate with it via my phone app.
>>>
>>> I *think* I’ve discerned that there may be 3 different ways I could do this?
>>>
>>> 1) Just use the hcitool/hciconfig command line tools. Work out all the hairy details of the various HCI command bytes, and write a script or something that just calls these command line tools. Not sure how I would be notified when a characteristic had been updated.
>>>
>>> 2) There’s a C library. So write a C program that cross compiles for the ARM, including the ARM headers for the bluez stuff. I have not seen a rigorous reference document for these APIs. I’m assuming it’s “use the source Luke”.
>>>
>>> 3) There’s a dbus interface. I appear to have dbus running on my device. But I have zero experience with interfacing with dbus, and I have yet to find any overview of what the bluez-dbus protocols look like. Would this be more general to weld a python3 script to though?
>>>
>>
>> I am not that much familiar with embedded. But I tried below things in Ubuntu.
>> There are few python scripts in bluez git tree which is using DBus interface.
>> https://git.kernel.org/cgit/bluetooth/bluez.git/tree/test/example-gatt-server
>> https://git.kernel.org/cgit/bluetooth/bluez.git/tree/test/example-advertisement
>>
>> 1) Run bluetoothd with experimental flag enabled (# sudo ./src/bluetoothd -ndE).
>> 2) Run the above mentioned script.
>> 3) # ./test/example-gatt-server -- it exposes 3 services.
>> 4) # ./test/example-advertisement -- it will advertise a sample data.
>> 5) Finally you can capture these via your phone app.
>>
>> You can edit those python scripts to meet your needs.
>>
>> This is very basic information. Let others comment on this.
>
> First of all, belated thanks to Gowtham and the others. I didn’t make immediate progress because of holidays and other distractions, but once I got at this, have been able to make _some_ progress quick.
>
> I changed my bluetooth.service to include the -E option. And I took the example-gatt-server and example-advertisement and started molding/shaping. In both cases, I’ve been able to python3ize them, and can now see it advertised as well as see my single service.
>
> My single service has a single characteristic that I’m trying to configure as a [‘write’, ‘notify’]. Both Service and Characteristic are “custom” with 128bit UUIDs. I’ve been using the iOS LightBlue app to connect to it. Which it does. When I cause a WriteValue() to occur on my Characteristic, I can see debug info from print() statements, but it doesn’t seem to send methods to the object. The iOS app prints back something like:
>
> “Characteristic Notified”
> “No User Description”
> “No value”
>
> My subclasses for Characteristic/Service look like:
>
> class MainService(Service):
>    UUID = '00000000-08af-41c0-8048-4215e1560a37'
>
>    def __init__(self, bus, index):
>       super().__init__(bus, index, self.UUID, True)
>       self.add_characteristic(DataStreamCharacteristic(bus, 0, self))
>
>
> class DataStreamCharacteristic(Characteristic):
>    UUID = '00000001-08af-41c0-8048-4215e1560a37'
>
>    def __init__(self, bus, index, service):
>       super().__init__(bus, index, self.UUID, ['write', 'notify'], service)
>       self.sendBuffer = []
>
>    def _foo_send1(self, byte): # I USED A WEIRD NAME BECAUSE I WONDERED IF THERE WAS SOME RESERVED THING GOING ON
>       print('appending:', byte, type(byte)) # THIS NEVER SHOWS UP
>       self.sendBuffer.append(dbus.Byte(byte))
>       print('sendBuffer:', self.sendBuffer) # THIS NEVER SHOWS UP EITHER
>       if len(self.sendBuffer) == 20:
>          self.flush()
>
>    def flush(self):
>       print('flushing:', self.sendBuffer)
>       self.PropertiesChanged(GATT_CHRC_IFACE, {'Value': self.sendBuffer}, [])
>       self.sendBuffer[:] = []
>
>    def WriteValue(self, value):
>       print('write:', value)  # THIS SHOWS AN ARRAY WITH THE VALUE THE APP SUPPOSEDLY WROTE
>       for byte in value:
>          print('got byte:', 0 + byte) # THIS SHOWS UP _ONCE_
>          print('sending byte:', 255 - byte) # THIS SHOWS UP _ONCE_
>          self._foo_send1(255 - value) # BUT I QUESTION WHETHER THIS EVER HAPPENS, SEE ABOVE
>
>    def StartNotify(self):
>       pass
>
>    def StopNotify(self):
>       pass
>
> The ALLCAPS comments in the code above show what happens when the WriteValue() method is apparently called. I’m completely confused as to what’s going on here. Is this some sort of nuance with the dbus/gobject bindings?
>
> I’m also wondering if I need to be doing something to set up some sort of Descriptors? I admit I’m fuzzy on what the descriptors do and how they work. The previous 2 experiences I’ve had with BLE, the descriptors seemed to be automagically managed.


I'm not sure if I can directly help you on this. However I did want to
point you towards a resource that might help you.

Martin Woolley (from the BluetoothSIG) has a good video that tries to
explain about how services, characteristics and descriptors interact
at https://youtu.be/auApsoMHxtA?list=PL2c6RSvzuF5EmNckwoKYhDUi0O7kDQiaL
There is a problem with the audio for the first few minutes but stick with it.
He also talks about a tool (Bluetooth Developer Studio) to help people
create services etc. I've not looked at the tool myself but seemed
useful from his demo.

I'm also new to using BLE and struggling with the lack of good Python
examples. I've had some success with reading Battery Services and
creating an Eddystone URL beacon using the Bluez DBus API. My plan is
to clean my experiments up and put them at
https://github.com/ukBaz/python-bluezero under an MIT license as
examples for others. Hopefully the library will have an API that will
save people from doing the same boilerplate code over and over again.
There is nothing there at the moment but please keep an eye on the
repository and if you can contribute with what you have learnt it
would be appreciated.

Regards,
Barry
