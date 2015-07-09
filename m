Return-Path: <cyrus@holtmann.org>
Message-ID: <1436456267.26457.24.camel@redhat.com>
Subject: GATT service DBus interface violates DBus spec
From: Nathaniel McCallum <npmccallum@redhat.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Thu, 09 Jul 2015 11:37:47 -0400
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The GATT service DBus interface currently requires that services
implement the following interfaces:
- org.freedesktop.DBus.ObjectManager
- org.freedesktop.DBus.Properties
- org.bluez.GattService1

An unwritten expectation is that the ObjectManager's GetManagedObjects
method should include the object itself in its return value. However,
the spec for GetManagedObjects states otherwise.

This currently works only because gdbus violates the spec.[1] Until
today, systemd's sd-bus library was compliant with the spec and thus
behaved differently from gdbus, making it impossible to use sd-bus with
bluez.[2]

I agree with Lennart's proposal that the best course of action is to
fix the spec, not the implementations. This would mean that no change
is needed for bluez (other than perhaps some documentation). However, I
wanted to raise awareness of this problem in case:
1. there is strong opposition to this proposal
2. others run into the same problem I did

[1] https://bugs.freedesktop.org/show_bug.cgi?id=91283
[2] https://github.com/systemd/systemd/commit/92d16a53e385781a55d9231d9
f8f89c1747ab0e4
