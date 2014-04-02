Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: USB autosuspend causing trouble on Intel bluetooth (Linux 3.14)
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <533C8F3C.6090306@archlinux.org>
Date: Wed, 2 Apr 2014 15:39:25 -0700
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Message-Id: <922DC347-921E-4B82-9843-7758BD096854@holtmann.org>
References: <533C8F3C.6090306@archlinux.org>
To: =?windows-1252?Q?Thomas_B=E4chler?= <thomas@archlinux.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Thomas,

> I am having trouble due to the following commit, which landed in 3.14:
> 
> commit d2bee8fb6e18f6116aada39851918473761f7ab1
> Author: Tedd Ho-Jeong An <tedd.an@intel.com>
> Date:   Tue Nov 12 13:16:41 2013 -0800
> 
>    Bluetooth: Enable autosuspend for Intel Bluetooth device
> 
> I have an Intel bluetooth dongle (8087:07dc) built into a Thinkpad. I
> primarily use it with my bluetooth mouse. Whenever I stop using the
> mouse for a few seconds, the mouse stops working. When I turn it off,
> the bluetooth applet on my desktop shows it as connected indefinitely. I
> can fix this situation by either of these actions:
> * restart bluetooth.service
> * disable+reenable bluetooth in the bluetooth applet
> * modprobe -r btusb && modprobe btusb
> The mouse then works again until I stop moving it for a short while.
> 
> The culprit is USB autosuspend. When I explicitly disable it (echo 'on'
>> power/control), the mouse works fine again. However, due to the
> aforementioned commit, I need to do this manually after every boot and
> every resume, because btusb keeps setting it back to 'auto'. I have
> found no way of overriding this behaviour.

what USB controller do you have your Bluetooth controller attached to. I had the same issue, but it went away when some of the xHCI host controller fixes got merged. Some other reported issues with some USB 2 controllers.

You can easily check by running the "Inquiry (LIAC)” test from tools/hci-tester. Problem is that some of the HCI events are not making it to the host. They get delivered as soon as the device wakes up again. In this test case it is the Inquiry Complete event. If you poke the controller and send a new command, the even will be magically dequeued.

Regards

Marcel

