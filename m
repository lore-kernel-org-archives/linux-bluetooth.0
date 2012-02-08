Return-Path: <cyrus@holtmann.org>
Message-ID: <1328678855.28848.6.camel@aeonflux>
Subject: Getting L2CAP ERTM support into better upstream state
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Date: Wed, 08 Feb 2012 06:27:35 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello everyone,

we currently have the problem on our hand that our upstream L2CAP
support is not as good as it should be. And many Android products start
deviating from it to fix issues with. That is of course something we can
not have. Fragmentation on this level is not useful for anyone. It will
hurt everybody in the longterm. So I asked Mat to port over the QUIC
code to the latest upstream so we can start a discussion here.

https://www.codeaurora.org/gitweb/quic/bluetooth/?p=bluetooth-next.git;a=commit;h=d02ef660d1ec9e9312798561fd688a4c717d339e

To make one thing perfectly clear here. I want that our upstream code
reflects the state machine transition from the L2CAP specification. I
know that historically this was not the case and that was for a reason.
All early specification where pretty unclear in this area, but with the
introduction of ERTM the Bluetooth SIG got this fixed and now it is our
time to get this clearly into our code as well.

With the separation of L2CAP channels from L2CAP sockets this should
make it even more easier to use since we do not need and should not to
use socket states anymore anyway.

Regards

Marcel


