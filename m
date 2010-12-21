Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 21 Dec 2010 17:12:08 -0300
Message-ID: <AANLkTi=px0CQY+W9PqrjMHZGQ6RdXgbd-iQo=K8AA_H6@mail.gmail.com>
Subject: [RFC] LE General Discovery Procedure
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi folks,

I'd like to receive opinions of how we should implement the General
Discovery procedure aligned to UI/API and Bluetooth Qualification.
The current implementation reports all found devices using the D-Bus
signal DeviceFound(), Flags AD Type is ignored at the moment, meaning
that Broadcaster and Peripheral are reported.

>From Bluetooth SPEC: General Discovery Procedure -  page 1704

"The Host shall check for the Flags AD type in the advertising data.
If the Flags AD type is present and either the LE General Discoverable
Mode flag is set to one or the LE Limited Discoverable Mode flag is
set to one then the Host shall consider the device as a discovered
device, otherwise the advertising data shall be ignored."

GAP Test Requirement document says that "General Discovery Procedure
Does not find Broadcast device"

We may need to represent the Broadcaster devices creating a D-Bus
device object, it is still unclear to me at the moment. So I have
three suggestions(I prefer the first):
1. Report Peripheral and Broadcaster using DeviceFound() signal and
add an property to identify the role. eg: Broadcaster=false/true
2. Ignore the Broadcaster devices. Means that it will not be possible
to call CreateDevice for these devices.
3. Add a config option to change the discovery behavior to ignore
Broadcaster devices. For qualification test only.

If we choose the first, for qualification test I guess it will be
enough to add an extra filter to ignore the broadcaster devices in the
BlueZ test script.

Regards,
Claudio
