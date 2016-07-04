Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: LE ControllerMode fails with Google Chrome
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAEZxfGPM1-3+4CP5zeNT7yEkp+8BNeaq6oFBroPX2YLdKpy3DA@mail.gmail.com>
Date: Mon, 4 Jul 2016 19:30:29 +0200
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <48C686F7-A30F-4939-AD7C-D9F9E6B87306@holtmann.org>
References: <CAEZxfGPM1-3+4CP5zeNT7yEkp+8BNeaq6oFBroPX2YLdKpy3DA@mail.gmail.com>
To: =?utf-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Francois,

> When setting "ControllerMode = le" in /etc/bluetooth/main.conf file,
> starting a dual scan from Google Chrome fails as you can see below.
> 
> Run ./chrome --enable-web-bluetooth
> Go to https://googlechrome.github.io/samples/web-bluetooth/automatic-reconnect.html
> Click "Scan button"
> Bluetooth chooser should show nearby Bluetooth devices. Sadly it only
> returns the ones in cache.with "ControllerMode = dual"

if you tell bluetoothd to configure a dual mode controller as it is a single mode controller, then only LE side will work. The kernel will block any attempt to use dual mode or BR/EDR functionality. However this might be a simple bug somewhere in the code that accidentally tries to use dual mode on a single mode controller.

Should be rather easy to fix if you can pin-point down the line of code that does this wrong. In general this should not be exposed to the D-Bus interface as an error. It should do the right thing depending on what controller is used or how it is configured.

Regards

Marcel

