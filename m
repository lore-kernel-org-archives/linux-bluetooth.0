Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: Unable to re-connect paired LE device after MAC rotation
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAD0=r8wrEw4zPxAxph1pGg3VGNxnQ8smh45qGn1YYbwmMQr8BQ@mail.gmail.com>
Date: Tue, 2 Jun 2015 04:56:42 +0200
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <DEB8F453-F8E5-4DAD-AC7B-9303601173BA@holtmann.org>
References: <CAD0=r8wrEw4zPxAxph1pGg3VGNxnQ8smh45qGn1YYbwmMQr8BQ@mail.gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

> 1. Have iPhone and Linux machine running latest BlueZ on latest
> kernel. iPhone have random mac "ABC".
> 2. Connect from BlueZ to iPhone, pair with PIN. iPhone real mac
> address "XXX" is being shown right now. I can connect to it form
> bluetoothctl using "XXX"  address, btmon shows it's random mac address
> "ABC" in connect request.
> 
> 3. Restart bluetooth on iPhone. It's random mac is rotated to "BCD".
> Try to connect from bluetoothctl using "XXX", btomon still shows old
> mac address "ABC" in connect request, therefore it'll fail and will be
> unable to connect.
> 
> That's a bug is, right ? BlueZ should be smart, and for paired device
> it should start a "Selective Connection Establishment Procedure"
> instead of "Auto Connection Establishment Procedure", as described in
> BT spec 4.2 [Vol 3, Part C] 9.3.7 .
> 
> 
> If I now manually start discovery before calling connect BlueZ would
> pick new iPhone address, "BCD" and use it for connection if I try to
> connect to "XXX".
> 
> Is that something that should be fixed ? If yes I'll spend some time on it.

I think the problem you see is that we call HCI LE Create Connection directly without doing a scan first. This has been long on the list that we should actually scan to find the device first and only then call HCI LE Create Connection.

Check debugfs entries in /sys/kernel/debug/bluetooth/hci0 that the IRK list really lists the IRK and last known RPA of the iPhone. That makes sure that we could resolve the address. And then try to scan first before trying to connect again. If that then does the trick and updates the known RPA of the iPhone to the new one, then it is problem that we do not scan before calling connect.

Regards

Marcel

