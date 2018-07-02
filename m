Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 02 Jul 2018 19:31:28 -0400
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: David Krauser <david@krauser.org>
Reply-To: David Krauser <david@krauser.org>
Subject: Determine ATT MTU size over DBUS
Message-ID: <Vd5Hg1KzgalysaxK8wZu5wyXhzrIeNpwpHrqD6JzDGdK6926uwNchApKq9lnhrOPr7Y6Xb0Cgzzu-vWt8lvB-JRRxXhAmSPzjikGfg5kkSc=@krauser.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'm working on an application that uses the bluez D-Bus bindings to registe=
r a GATT service and characteristic, but I'm having two issues:

1. I can't figure out how to get the negotiated MTU size for reads/writes t=
o my characteristic.

I saw that the AcquireNotify and AcquireWrite calls provide an MTU in the o=
ptions dictionary, but there's no MTU provided for the WriteValue or ReadVa=
lue calls.

2. I can't figure out how to dynamically change the max MTU size to use wit=
h my service.

I saw that you could change the max MTU size by changing some #define's in =
the bluez source code, but I couldn't find a way to change it dynamically (=
like how you can change the ACL/SCO MTU sizes).

Is there something I'm missing? If not, would you all be open to a patch th=
at adds the negotiated MTU size to the options dictionary on calls to ReadV=
alue and WriteValue?

Or even better, I could add a new method to the GattCharacteristic1 interfa=
ce that is called during MTU negotiation. It would receive the requested MT=
U size as an input, and the developer could choose to use that size, or ret=
urn a different size to use.

Thanks,

- dk
