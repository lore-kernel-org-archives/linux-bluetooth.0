Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Thu, 26 Jan 2017 17:25:34 +0000
From: Dario Teixeira <dario.teixeira@nleyten.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Exchanging data over Bluetooth Classic
Message-ID: <f0f88082abcb4aa700ca2e7898fc75b9@nleyten.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here's the situation: I want to use a smart phone to communicate with
a small embedded device (ED).  Unfortunately the ED is running a very
old kernel (3.10.93) which does not support Bluetooth Low Energy.
Therefore, if I am to use Bluetooth it will have to be BT Classic.

The communication is pretty straightforward: just a couple of RPC
calls using JSON.  Both the requests and the replies are reasonably
short.  The entire exchange can be summarised as follows:

  Phone: Here's request #1 (JSON text).
  ED: Okay, here's reply #1 (JSON text).
  Phone: Here's request #2 (JSON text).
  ED: Okay, here's reply #2 (JSON text).

Now, I have a couple of related questions:

a) I presume there's no other option than using RFCOMM, right?

b) I know that the first Google hit for "Bluetooth programming"
    is hopelessly out of date [1], because Bluez now uses DBus.
    However, where's the Bluez documentation for RFCOMM via DBus?
    I could only find this page for Bluez documentation [2],
    but RFCOMM is not mentioned.

Thanks in advance for your time!
Best regards,
Dario Teixeira

[1] https://people.csail.mit.edu/albert/bluez-intro/
[2] http://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc

