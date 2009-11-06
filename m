Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 6 Nov 2009 16:40:27 +0530
Message-ID: <912bb79a0911060310t71211862q3c39fe3e08486d2a@mail.gmail.com>
Subject: headset service search problem
From: nirav rabara <niravrabara@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I have been trying to search only headset devices among other
bluetooth devices using SDP.

Problem - 1)

-> when I search for UUID 0x1108 (for headset). It shows me mobile
devices also because it support headset service
   Is there any other way to search  particularly for headset only??

Problem - 2)

-> when I search for the search for the service(headset). Bluetoothd
is going to get PIN no. because sometimes link key gets fail (in case
of new headset device whose is getting connected first time ).
-> Why bluetoothd need PIN when I am try to search for the service.
(not connecting)

Is there any way to search for the services without entering PIN ??

with regards,
Nirav
