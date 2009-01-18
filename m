Return-Path: <cyrus@holtmann.org>
Subject: Re: Dell Wireless 360 Bluetooth HID devices not being remembered
 over suspend/reboot
From: Marcel Holtmann <marcel@holtmann.org>
To: Matthew Grant <matthewgrant5@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <b3f4dcd00901161441n6e2d98e6l193bcc8372fd2bc8@mail.gmail.com>
References: <b3f4dcd00901161441n6e2d98e6l193bcc8372fd2bc8@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 18 Jan 2009 16:13:36 +0100
Message-Id: <1232291616.5095.13.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Matthew,

> I know that this is a developers list, but I have dug pretty deeply
> here and got to the bottom of what the built-in USB bluetooth dongle
> is.  I have found that its CSR based.   Under Windows Vista my Apple
> keyboard and Logitech MX 900 work and are remembered across boots.
> From what I have heard, this device should just work.  System is a
> Dell Vostro 1510 with Intel Core2Duo running Ubuntu Intrepid Ibex,
> bluez 4.22.  I also have an Intel 3945 ABG PCI mini wireless card in
> it as well.
> 
> I am willing to do the hacking to get this going - I used to submit
> patches to the Linux kernel and develop/patch network drivers for
> Frame Relay WAN, as well as making the 2.2x ehternet bridge accessible
> via a virtual ethernet interface - my email address was
> grantma@anathoth.gen.nz.
> 
> Should I be using the module flags for a straight CSR modem?  Is the
> kernel module btusb ths only place the bluez stack looks hard at the
> hardware?
> 
> From what I have found looking at posts to the list, the CSR dongle,
> once it is set up properly - I don't mind running a CSR DFU firmware
> on it - it should just work.
> 
> I am going to test software by using my old Logitech dongle in the MX
> 900 base station-charger.
> 
> Getting the mouse going reliably and keyboard is going to help with my
> frustrations with the small sized keys on the laptop keyboard when
> essay writing - currently  I am rebinding the OOo.org keys into an
> emacs type of keymap.
> 
> lsusb and hciconfig -a output follow.  Is there anything else that may
> be helpful?
> 
> I gather that solving this will help out a lot of Ubuntu Dell laptop users.

check with "hciconfig hci0 revision" and "bccmd buildname" (both as
root) if they have a special Dell firmware running on it. If not then
there can be still a Dell custom application running in the VM of the
Bluetooth chip.

Best bet is to ask Mario from Dell if he can help us out here and maybe
make HID/HCI switching persistent across reboots. If not then we might
have to write a bluetoothd plugin that does the job for us.

Regards

Marcel


