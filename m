Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Alex Deymo <deymo@chromium.org>
Date: Mon, 29 Apr 2013 14:51:25 -0700
Message-ID: <CAGd9gwjbOFpaYrZt=4Pn4VLUNX-uq-Ap=pPaWt9snV_Gmiwmtg@mail.gmail.com>
Subject: Paired devices in discovery mode
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	keybuk <keybuk@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!
I'm wonder to solve the following situation:
1. You pair your BT device with your computer and use it.
2. Then go somewhere else and pair it with another computer to use it there.
3. Finally you go back to the first computer and want to use the
device again with the first computer.

In this situation, depending on the device, the first pairing could be
lost if the device supports only one pairing. Some mice/keyboards
support only one pairing, but there are also other devices supporting
more than one pairing at each time.

If the device lost the pairing, the connect attempt with the device
will likely reject our link key. With the current BlueZ, this is
"Paired: yes" for us, but we can't initiate the secure connection. To
solve this we would need to, in order:
1. Remove the device.
2. Wait for the device to appear in the discovery session.
3. Pair again with the device (re-trust is if needed, etc).

Can we solve this or make it easier?
I'm thinking about adding a "Discovering" boolean property to the
Device1 interface that tells you if a device (paired or not, connected
or not) is in discovery mode. We know that because we see an inquiry
response while discovering. I would also modify the "Pair" method to
allow to re-pair a device that is Paired and Discovering instead of
returning an error for that case.
What do you think?

Alex.
