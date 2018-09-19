Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Nazmul Alam <fadedreamz@gmail.com>
Date: Wed, 19 Sep 2018 18:11:41 -0400
Message-ID: <CACjvaw=rr-MDiBZH6rM1BORBH372ZXLkSrxpPsKjP6dMGo4TZg@mail.gmail.com>
Subject: Problem with two dongle simultaneously
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I am trying to run two bluetooth dongles simultaneously for two
separate devices.
One device is communicating over classic BT while the other one is using BL=
E.
When both devices are running (approximately 250hz sampling rate), the
BLE is dropping packets (most of the samples are gone).
I am using pygatt to capture the data and it appears to happen when
the pygatt chokes and python takes 100% of a single cpu core.

bluetoothctl also shows strange behavior with two controllers. Even
when a particular controller is selected, it can not show the
paired-devices correctly, unless the other one is plugged out (the mac
is different on both dongles).

Now, the question is, in bluez is it problematic to run two dongles
simultaneously considering both of them are active and pushing data?

I am trying to get a more experienced opinion to pinpoint the
problematic part of the setup (pygatt or bluez).

bluez - 5.41
arm64 - kernel 4.4+
dongles - csr 4.0

Thanks

--=20
with best regards,
       Nazmul Alam Shovon

=E0=A6=B6=E0=A7=81=E0=A6=AD=E0=A7=87=E0=A6=9A=E0=A7=8D=E0=A6=9B=E0=A6=BE=E0=
=A6=A8=E0=A7=8D=E0=A6=A4=E0=A7=87,
       =E0=A6=A8=E0=A6=BE=E0=A6=9C=E0=A6=AE=E0=A7=81=E0=A6=B2 =E0=A6=86=E0=
=A6=B2=E0=A6=AE =E0=A6=B6=E0=A7=8B=E0=A6=AD=E0=A6=A8
