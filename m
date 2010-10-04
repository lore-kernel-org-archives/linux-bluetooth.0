Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 4 Oct 2010 10:02:49 +0530
Message-ID: <AANLkTikZoTVviRRMs-Rb+Ygkt4=3mUmHH9wwXGV8rV5r@mail.gmail.com>
Subject: can not connect to Headset after pairing, please suggest
From: "Yedire, Sandeep" <syedire@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello All,

I have been trying to connect to Bluetooth headset from the target.
I am able to see the connection status from pairing mode to paired
mode when I do ./agent 0000 <bdaddr>. Here Red-Blue blink will respond
to the agent(executable) and change to blue-blue blink.
Later Thru a2play or avtest, l2test (part of btsco, bluez) I get
connection refused-146. I tried hcidump running in back ground and
found connection refused -Security Block. Also the headset enters into
a mode where it does not take any pass-key.

I do find that pairing was successful but why do I get this error
message. Am I missing any step in between? Is there any place where
some pairing information is stored some where so that this remains in
connected state and do not ask for pass -key again.

Can some one take time to suggest me how pairing is to be done with
headset detailing in each step so that I don't miss any ?

Regards,
Sandeep.Yedire

----------------------------------------------------------
T.Jefferson, 'Victory and defeat are each of the same price"
