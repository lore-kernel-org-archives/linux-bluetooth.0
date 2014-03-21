Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 21 Mar 2014 14:15:32 +0100
Message-ID: <CAO0DSOQixu69dH5oaGX2DnvsQH0rcykSvxADh1x+P-C65qwaew@mail.gmail.com>
Subject: ble - bluez question
From: david Sanda <david.sanda@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi everyone, this is my first post here.
I am trying to develop ble peripheral on my linux box using asus bt400
dongle to mimic my hardware project with the ble peripheral and i
would like advice on how to accomplish some things beyond my limited
progress.
I understand, that gatt-example.c plugin is the way to go and that it
is built in bluez bluetoothd. hciconfig hci0 leadv makes it work. For
authorization, simple-agent service does the job, at least some of the
times.
I do understand about gatt infrastructure. Shame it is not oid based
like any sensible system, but no matter.
I would like help on the following..

a)How do i make simple-service example work? It looks like a
standalone gatt server, however when i run it, it crashes with
dbus.exceptions.DBusException:
org.freedesktop.DBus.Error.UnknownMethod: Method "AddRecord" with
signature "s" on interface "org.bluez.Profile1" doesn't exist
on the handle = AddRecord(xml) line.
b)is the notification support in the gatt working as expected? I read
few comments in the bluetooth archive, that it might not be so.
c) is there a way to keep the peripheral advertising instead of having
to reissue leadv command after each connection?
d) plugin mechanism - is it enough to  recompile gatt-example as
external plugin and place it into plugins directory to make it work
independently?
thanks


David
