Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [RFC 3/5] Bluetooth: hci_uart: Add HCIUARTSETBAUDRATE ioctl
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <5527BD05.1070409@hurleysoftware.com>
Date: Fri, 10 Apr 2015 09:07:40 -0700
Cc: Loic Poulain <loic.poulain@intel.com>,
	Frederic Danis <frederic.danis@linux.intel.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.cz
Message-Id: <1D99FD1A-264A-438A-95CE-6F36B972D73B@holtmann.org>
References: <1427985456-31536-1-git-send-email-frederic.danis@linux.intel.com> <1427985456-31536-4-git-send-email-frederic.danis@linux.intel.com> <551E717A.6040500@hurleysoftware.com> <551E8C6A.8040009@linux.intel.com> <551E9987.9050800@hurleysoftware.com> <551EA13B.7010307@intel.com> <551EB5A1.9040409@hurleysoftware.com> <D74E0673-5A60-4E8F-A050-60DB4A0F43A7@holtmann.org> <55206E46.10706@hurleysoftware.com> <A3143A1C-D32E-4EE4-A52B-446160A5F484@holtmann.org> <55208E65.503@hurleysoftware.com> <4ACA6164-2D6E-4A65-8842-492FB01DF81C@holtmann.org> <5527BD05.1070409@hurleysoftware.com>
To: Peter Hurley <peter@hurleysoftware.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

>>>>>>>>> The line discipline is always notified of line rate changes
>>>>>>>>> via the set_termios() method, so if you add that to the hci_ldisc,
>>>>>>>>> you'll be able to keep the BT device in sync with your
>>>>>>>>> vendor-specific commands.
>>>>>>>> If I'm not wrong, line discipline is notified after the tty termios change.
>>>>>>>> So, it's too late to send the  HCI change speed command.
>>>>>>>> Moreover, user space is not aware of the device behavior, the driver should
>>>>>>>> be the only one to manage the device and its serial link.
>>>>>>>> Here, user space is just a bootstrap which hands over to the driver.
>>>>>>> 
>>>>>>> You realize that you're telling me that userspace is unaware of
>>>>>>> this in a thread that begins with a proposed userspace ioctl change to
>>>>>>> the line discipline? An ioctl change that adds a new ioctl to set the
>>>>>>> speed in a line discipline? For which there are already lots of ioctls
>>>>>>> to set the line speed?
>>>>>> 
>>>>>> actually the problem is a little bit different here.
>>>>> 
>>>>> Thanks for taking the time to outline the operation of hciattach. It's
>>>>> been a while since I was involved in the BT userspace code so I hadn't
>>>>> realized how much hciattach had morphed.
>>>>> 
>>>>>> Every Bluetooth UART chip has its default baudrate. Mostly that is 115k, but some actually have others.
>>>>>> 
>>>>>> The general idea was that userspace deals with opening the TTY, send the HCI commands to change the rate, then change the termios setting, attach the ldisc and then hand it to the kernel.
>>>>>> 
>>>>>> This is however not how at least two major Bluetooth controllers work when you have to do firmware loading. When they boot into the firmware, then baudrate falls back to default and you have to do that all over again.
>>>>>> 
>>>>>> So what this ioctl will just tell the kernel about is the desired baudrate that it wants to be set whenever possible. The whenever possible is important here since depending on the manufacturer that might be a total different times. And with firmware download procedures being fully vendor specific this will vary.
>>>>>> 
>>>>>>> Setting aside the problem with the firmware load, I see no reason why
>>>>>>> this can't be done within the existing line discipline framework.
>>>>>> 
>>>>>> So far everything has been done in hciattach tool. And it is so ugly and does not even work properly for any complex UART protocols like BCSP or 3-Wire. There is a patch for a modified 3-Wire setup from one vendor that made my eyes bleed. So what you really want is having the kernel take control over HCI from the beginning. Otherwise this goes out of control and handling exceptions like hardware error event becomes impossible.
>>>>>> 
>>>>>> In summary what we have to do these days is this:
>>>>>> 
>>>>>> - Send Reset
>>>>>> - Send a few basic HCI commands
>>>>>> - Send baud rate change command
>>>>>> - Change actual baud rate on the TTY
>>>>>> - Download firmware
>>>>>> - Send Reset to boot the firmware
>>>>>> - Change actual baud rate back to default
>>>>>> - Send baud rate change command
>>>>>> - Change actual baud rate
>>>>>> - Send Reset
>>>>>> - Standard init sequence
>>>>>> 
>>>>>> Now tell me how the line discipline framework helps us here?
>>>>> 
>>>>> Well,
>>>>> 1. in hciattach I would have set the N_HCI line discipline immediately
>>>>> after opening the uart device.
>>>>> 2. in the N_HCI line discipline, I would have implemented write() so
>>>>> userspace command write()s would still write through to the uart
>>>>> device.
>>>>> 3. either,
>>>>> a. I would have added a new line discipline method for pre-termios changes, or
>>>>> b. I would have caught set termios ioctls in the N_HCI line discipline ioctl.
>>>>> 
>>>>> and handled sending target line speed change commands there.
>>>>> Userspace would simply change the line speed.
>>>>> 
>>>>> Userspace firmware loads are straightforward.
>>>>> 
>>>>> However, it seems that the new intel approach (tied in with the protocol)
>>>>> is trickier to accommodate, but I haven't spent a lot of time trying to follow
>>>>> that setup.
>>>>> 
>>>>> I'm not sure I understand why the firmware load is tied to the protocol;
>>>>> can the intel part load a different firmware that implements a different protocol?
>>>> 
>>>> the firmware loading procedure for USB and UART is actually the same. That applies to Broadcom and Intel controllers for sure and most likely also for other vendors. One goal is to share the firmware loading code between USB and UART based SKUs of these controllers. Where are not there yet, but that is where this is heading. So while we can hack around certain things in userspace, we really do not want to do that since it just means duplicated code.
>>>> 
>>>> Implementing the write() is a bad idea in my opinion. That is like injecting HCI commands behind your back. All sorts of messy things can happen if you allow that. And that is why this is actually not even implemented at the moment. Remember that HCI protocol comes with flow control for their commands and events. Injecting something without taking care of the command flow control means you are doing evil stuff. The firmware loading is using HCI commands and thus it should go through the high-level Bluetooth core that understands HCI commands.
>>> 
>>> hciattach is doing lots of write(fd) right now; those raw serial writes would simply be
>>> going though N_HCI line discipline write() instead of the N_TTY line discipline write().
>> 
>> and we want to get rid of these since it implements the HCI protocol layer. And it implements it pretty poorly. It is mainly write(), fingers-crossed, hope you get the right bytes back.
>> 
>> It works for dead simple protocols like H:5, but for BCSP, 3-Wire or the vendor specific power management, this is all not going to work out. The problem area arises when you have to recover from an error. All of this falls flat on its face.
> 
> Ok, what code should I look at to understand your in-kernel interface
> requirements?

the chips are using mainly HCI vendor commands with in some cases extra packet types for power management. The kernel side is mainly that we have a special setup routing that drivers can use to program the controller. However the driver uses HCI commands via __hci_cmd_sync(). Good example from bluetooth-next might be drivers/bluetooth/btbcm.c since there we already split out the common pieces. Keep in mind that the HCI commands are in most cases the same no matter what the transport underneath is. UART just needs an extra baud rate change.

> Is it at least from process context?

The setup callback in executed from a workqueue.

>>>> Our idea is essentially that we set the N_HCI line discipline and then set the vendor protocol. That is it. From that point on it is the kernels problem to handle the bringup of the Bluetooth device. Including firmware download, address configuration and so on. Before setting N_HCI we would correctly configure the default baudrate and all other needed settings. However that is as much as we do from userspace.
>>>> 
>>>> For this to work, we need to be able to tell the TTY to change its baudrate. And this has to happen at least 3 times now. Higher baudrate before downloading the firmware, back to default baudrate after that, switch to higher baudrate and only then we are at normal operation.
>>>> 
>>>> So how does intercepting the termios ioctl will help us in this regard. The kernel needs to control the baudrate change and not userspace.
>>> 
>>> The tty is a userspace object with a userspace api, simple as that.
>>> That's why hciattach has to stay alive, because it has to own the tty file
>>> reference.
>>> 
>>> Anything directly to tty from kernel is a hack that is missing locks and
>>> bypassing state.
>> 
>> So what you are saying is that we want to have a callback mechanism back into hciattach. So when kernel needs a changed baudrate, it should tell hciattach, it will then change the baudrate, and tell the kernel when it did so.
>> 
>> I wonder if I could just repurpose the ldisc read/write/poll callback handlers to implement such a simple callback/notification protocol. That would actually make sense to me since the kernel wants to drive the TTY with the agreed upon HCI transport protocol from the point we attached N_HCI to it.
> 
> Any of the above would be so ugly.
> Until I can work up something better, the lesser evil is using
> tty_set_termios().
> 
> Please cc me for patches using tty_set_termios() or other tty workarounds.

I was proposing to use tty->ops->set_termios. Is there any benefit from calling the native ops compared to using the not yet exposed wrapper?

>>>>>> Keep in mind you have to tell the controller via HCI commands over the old baud rate to change its rate. And then change it on the TTY to match what the controller does on its side.
>>>>> 
>>>>> I'm conscious of the limitations of using tty/serial in the current manner.
>>>>> 
>>>>> A fun project for one of these vendors would be to split the serial core
>>>>> into a separate tty driver and an abstraction layer that would allow other
>>>>> kernel subsystems to enslave the port.
>>>> 
>>>> They are proposing TTY slave devices and maybe that will help eventually, but finding agreement on that seems hard as well. And that is also mostly for handling the extra GPIO configuration for power up/down the Bluetooth chip behind the TTY and not the TTY itself.
>>> 
>>> That's different.
>>> 
>>>> I would love if we could just expose these TTYs as bi-directional pipes on a "serial bus" and just have a driver attach to it instead of going through a line discipline.
>>> 
>>> That's what I'm saying.
>>> 
>>> Ultimately, the stuff you want to implement on the BT side will need a native
>>> kernel interface where you own the device reference.
>> 
>> Even the HSU on our devices expose a TTY instead of an actual HSU bus where we could have be a HSU driver on it. If you know how we can get this changed, I am all ears.
> 
> There's no magic bullet here; it would be a lot of work.
> 
>> The hci_uart driver and N_HCI line discipline will be still needed since there are actual development boards with USB/TTY converters attached to it. However all the embedded devices where it is all hardwired, proper exposed busses or platform devices would be a lot better.
> 
> But never both simultaneously on the same device, right?
> Because the idea would be that the UART is exclusive and wholly owned, without
> a userspace dev node.

Yes. It is exclusive access to the device. No userspace device node needed.

So if we could just even set the line discipline from the kernel similar to attaching a driver to a device, then that would be something I would be interested as well.

Regards

Marcel

