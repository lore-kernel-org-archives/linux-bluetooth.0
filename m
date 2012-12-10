Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 10 Dec 2012 23:23:33 +0200
Message-ID: <CAGXs5wXbnXsFN811cFjiiYpLPkd7cM0dsLqMDE8xNemd3PN7WQ@mail.gmail.com>
Subject: input-headset driver probe failed for device
From: Kevin Wilson <wkevils@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hell,
I am not sure whether this is the right list, I hope somebody can advice.
I have two machines, both with bt devices; hciconfig shows both
devices as UP and
RUNNING with bt addresses.

I run server on one side:
pand --listen --role GN

On the second, I try to connect with:
pand -c serverBtAddress --service GN

I see this message (twice) on the server log:
bluetoothd[1392]: input-headset driver probe failed for device

Any ideas why ? can it be avoided ?

And on the client side I see: "Connect to serverBtAddress failed"

AND "hcitool con" shows no connections:
Connections:

any idea?
rgs,
Kevin
