Return-Path: <cyrus@holtmann.org>
Subject: Pairing with several Bluetooth dongles
From: =?ISO-8859-1?Q?Germ=E1n?= Pedrosa
	<german.pedrosa@fundacionctic.org>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 17 Nov 2009 11:33:29 +0100
Message-Id: <1258454009.5909.1.camel@german-desktop>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi guys,

I am involved in the developing of a Java project that uses Bluecove and
Bluez. This project makes use of several Bluetooth dongles, one of them
is dedicated to the task of scanning and the rest of them are focused on
carrying other Bluetooth operations over mobile devices.

Some of these operations need the pairing between the mobile device and
the dongle that executes the operation. One of the project objectives is
to avoid that the same user has to pair more than once against the
system. In order to tackle with this issue, I thought of assigning the
same MAC address to every dongle by means of "bdaddr" tool, so as to
when the user pairs with a dongle he automatically pairs with all of
them.  Once I have implemented this I have jumped into a problem: At the
end all the operations physically executes over the same dongle. My
questions are, ¿Does Bluez use MAC address instead of HCI in order to
select the dongle? If so, ¿would be feasible to modify Bluez to take
this into account?

Any thoughts on this would be very appreciated,

Best wishes,

Germán.


