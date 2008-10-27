Return-Path: <cyrus@holtmann.org>
Subject: Re: pairing of bluez-utils 3.36-1 with keysonic 340 BT fails (no
	PIN requested)
From: Marcel Holtmann <marcel@holtmann.org>
To: Fiorellino <fiorellino@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <40aff9180810251901l6ecfa88drd671c08a5ac33821@mail.gmail.com>
References: <40aff9180810251825w1085c6d6q5ee37406475809cf@mail.gmail.com>
	 <40aff9180810251901l6ecfa88drd671c08a5ac33821@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 27 Oct 2008 20:47:45 +0100
Message-Id: <1225136865.7157.30.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fiorellino,

> I have a keysonic bluetooth keyboard.
> It works perfectly under windows (I know you don't care, but at least
> the keyboard is working fine!) using the embedded BT controller of my
> laptop.
> 
> Now I'd like to use it under Debian lenny/sid in an embedded PC
> (alix3d3) using a Trust Ultra Small Bluetooth 2 USB Adapter.
> 
> With "apt-get install" I installed bluez-utils 3.36-1.

we are already at bluez-4.17 release. So 3.36 is pretty outdated and it
has a bug within its HID support.

Regards

Marcel


