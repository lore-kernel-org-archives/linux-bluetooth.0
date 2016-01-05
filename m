Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: Powered property and rfkill
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1451952088.8726.23.camel@hadess.net>
Date: Mon, 4 Jan 2016 23:07:10 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <6F22FCA1-16B6-4D4F-B147-1945039BFECD@holtmann.org>
References: <1451921293.8726.9.camel@hadess.net> <4D4B98FB-85B1-45D3-B445-205920C5C781@holtmann.org> <1451952088.8726.23.camel@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

>>> I was wondering the reasoning behind the recent changes in rfkill
>>> handling for hci interfaces, in particular the addition
>>> of MGMT_STATUS_RFKILLED as an error message.
>>> 
>>> Before those changes (for which I couldn't find an initial kernel
>>> side
>>> commit), the Powered state of the adapter was tied to its rfkill
>>> status.
>> 
>> actually RFKILL was never tied to the controller's power state.
>> Neither via mgmt nor via the old legacy ioctl that do the hciconfig
>> hci0 up. We also have an ERFKILL errno error code introduced for
>> RFKILL a long time ago. It is a special error code that you would get
>> when trying to hciconfig hci0 up or even ifconfig wlan0 up (in case
>> of WiFi).
>> 
>> RFKILL does two things, a) force an interface down in case it is up
>> and you RFKILL block it, b) return an error when you try to bring up
>> a blocked interface.
>> 
>> It always worked this way. The MGMT_STATUS_RFKILLED is just the mgmt
>> error status equivalent of ERFKILL.
> 
> OK.
> 
>>> When a soft rfkilled device showed up, which was to be the default
>>> adapter, bluetoothd would remember that it was powered, and
>>> unrfkill
>>> it. If the state was unpowered, or it had been rfkilled, GNOME's
>>> Bluetooth panel would set Powered to true, un-rfkill'ing the
>>> adapter.
>> 
>> I do not remember that automatic un-rfkilling from within bluetoothd.
>> Maybe Johan and Luiz remember something in this area.
>> 
>>> In 99% of cases, this meant that plugging in a Bluetooth adapter
>>> would
>>> work out of the box.
>>> 
>>> Now, bluetoothd doesn't remember the power state, and the rfkill
>>> isn't
>>> tied to the Powered state. Calling to set the Power state will fail
>>> with the "Blocked" error, and we're expecting something else to
>>> unset
>>> the adapter's rfkill status.
>> 
>> My feeling is that you are running into the case where something
>> changed in the RFKILL subsystem or how systemd started to interact
>> with RFKILL. I have seen the cases where it boots up with a soft-
>> blocked state, but I never really tried to analyze the case.
> 
> That's a more likely problem, yes. Removing the Bluetooth files
> in /var/lib/systemd/rfkill/*:bluetooth seems to solve the problem.
> 
> I'll still need to find a way to avoid those inconsistent state
> problems.

I was never a fan of systemd trying to mess with RFKILL states. If you are not connection manager, you really have not enough information about how to deal with RFKILL switches.

What I think is the problem that systemd might better really only handle platform RFKILL switches and starts ignoring the ones that come from Bluetooth subsystem as part of the HCI controller.

>> The automatic power and remembering of powered state has been removed
>> since BlueZ 5.0, but recently we have introduced the AutoEnable
>> main.conf option in case you prefer to always power on your adapters
>> during early boot. This helps for cases where Bluetooth needs to be
>> up before an user logged in, but it also means that no agent is
>> available. So choose that option wisely.
> 
> I was wondering whether changes around this were responsible for the
> problem.
> 
>>> What did the developers making those changes hope that would
>>> unrfkill
>>> and power up the adapter when plugged in?
>>> 
>>> Note that this might be a side-effect of the machine I'm using
>>> which
>>> has 2 layers of Bluetooth rfkill:
>>> $ rfkill list bluetooth
>>> 0: tpacpi_bluetooth_sw: Bluetooth
>>> 	Soft blocked: no
>>> 	Hard blocked: no
>>> 4: hci0: Bluetooth
>>> 	Soft blocked: yes
>>> 	Hard blocked: no
>>> 
>>> hci0 won't be visible if tpacpi_bluetooth_sw is soft-killed. The
>>> work-
>>> around I have planned is to wait for "hci*" to appear if the
>>> Bluetooth
>>> rfkill we unset doesn't start with "chi".
>> 
>> That is the Thinkpad specific platform RFKILL switch that kills the
>> power to the USB device. Some platforms have this switches. They are
>> owned by the platform or ACPI. The hci0 is the one represented by the
>> Bluetooth subsystem.
> 
> Right, knew that, but was wondering whether the layering of rfkills, in
> addition to other changes, might have been the reason why this broke.

I do not recall any change in the subsystem that have caused this. So most likely this is systemd messing up things.

Regards

Marcel

