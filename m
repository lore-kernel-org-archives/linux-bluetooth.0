Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Problems with LE Advertising using GDBus API
From: Alex Coplan <alex.coplan@starleaf.com>
In-Reply-To: <567E72EE-8264-4BCF-ABFC-925BF62725ED@starleaf.com>
Date: Mon, 27 Jun 2016 15:13:03 +0100
Message-Id: <7643C610-2B63-4572-AC3D-6A001F9CF8C0@starleaf.com>
References: <567E72EE-8264-4BCF-ABFC-925BF62725ED@starleaf.com>
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> On 27 Jun 2016, at 13:25, Alex Coplan <alex.coplan@starleaf.com> wrote:
> 
> Hi All,
> 
> I’m having issues getting LE Advertising to work using the GDBus API. I’ve managed to get my chip to advertise using the direct HCI socket API with e.g. this code (https://github.com/carsonmcdonald/bluez-ibeacon).
> 
> However, for writing my own code I’d prefer to use the higher-level (G)DBus API. I thought that tools/gap-tester might be a good place to start, since this appears to be written using the more modern, higher-level GDBus API. However, if I run this program, e.g. with:
> $ sudo ./gap-tester
> it just hangs, after printing:
> 
> Adapter setup - init
> Adapter setup - setup
> 
> To give a bit of background, this is on a clean Ubuntu 16.04 install (Kernel 4.4.0) with BlueZ 5.40 compiled from the source repository (but not installed). The unit tests (invoked with `make check`) pass fine. The chip I’m using is an ASUS USB-BT400. hciconfig gives:
> 
> hci0:	Type: BR/EDR  Bus: USB
> 	BD Address: 5C:F3:70:77:DE:0D  ACL MTU: 1021:8  SCO MTU: 64:1
> 	DOWN
> 	RX bytes:2142 acl:0 sco:0 events:65 errors:0
> 	TX bytes:988 acl:0 sco:0 commands:133 errors:14
> 
> On further investigation, I decided to run some of the tests in the tools directory. Running hci-tester gives the following summary:
> 
> Test Summary


Further to this, I have since run the same tests on an Intel chip and I obtained exactly the same results (except that I received one fewer failures in hci-tester; this is, however, unimportant).

It would be great if somebody could confirm whether this is a bug, or perhaps suggest any further investigation I should do? Perhaps I’m missing something obvious.

Many thanks,
Alex