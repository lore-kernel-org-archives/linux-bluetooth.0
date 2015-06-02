Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 1 Jun 2015 18:52:09 -0700
Message-ID: <CAD0=r8wrEw4zPxAxph1pGg3VGNxnQ8smh45qGn1YYbwmMQr8BQ@mail.gmail.com>
Subject: Unable to re-connect paired LE device after MAC rotation
From: Jakub Pawlowski <jpawlowski@google.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, I think I found a bug:

1. Have iPhone and Linux machine running latest BlueZ on latest
kernel. iPhone have random mac "ABC".
2. Connect from BlueZ to iPhone, pair with PIN. iPhone real mac
address "XXX" is being shown right now. I can connect to it form
bluetoothctl using "XXX"  address, btmon shows it's random mac address
"ABC" in connect request.

3. Restart bluetooth on iPhone. It's random mac is rotated to "BCD".
Try to connect from bluetoothctl using "XXX", btomon still shows old
mac address "ABC" in connect request, therefore it'll fail and will be
unable to connect.

That's a bug is, right ? BlueZ should be smart, and for paired device
it should start a "Selective Connection Establishment Procedure"
instead of "Auto Connection Establishment Procedure", as described in
BT spec 4.2 [Vol 3, Part C] 9.3.7 .


If I now manually start discovery before calling connect BlueZ would
pick new iPhone address, "BCD" and use it for connection if I try to
connect to "XXX".

Is that something that should be fixed ? If yes I'll spend some time on it.
