Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 5 Feb 2014 08:26:14 -0400
Message-ID: <CAPm3yA3cOM0auyzqPLdKj5FFFva-REk3TnsrZcD9siV6kba+eA@mail.gmail.com>
Subject: LE Connection Update Disallowed
From: Sandy Chapman <schapman@lixar.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

I've got a problem with issuing an LE Connection Update via the
hcitool's lecup command and I'm not sure why. Based on what I've read
online, this should be working.

Central: iPhone 5
Peripheral: Linux Mint 15 running kernel 3.11.0-12-generic (running in
a VM on a Mac Book)
I'm using a built from source Bluez off tag 5.14.

I establish an LE connection between the devices. The central
successfully discovers the services and characteristics and can read
them. Once the connection is established, I run this command on the
Linux peripheral:

$ sudo ./bin/hcitool lecup --handle 64 --min 24 --max 50 --latency 4
--timeout 550
>>> Could not change connection params: Input/output error(5)

In my hcidump -X, I get this:

< HCI Command: LE Connection Update (0x08|0x0013) plen 14
  0000: 40 00 18 00 32 00 04 00  26 02 01 00 01 00        @...2...&.....
> HCI Event: Command Status (0x0f) plen 4
    LE Connection Update (0x08|0x0013) status 0x0c ncmd 1
    Error: Command Disallowed

In my limited understanding, it looks like the command isn't being
issued. It doesn't appear that it's the iPhone rejecting the command,
but something local to the Linux install. Running hciconfig lestates
shows that all states are permitted ("YES" beside every entry).

The Bluetooth Spec (Volume 2, Part E, section 7.8.18) states that this
command shall only be used when the local device's role is master.
However, Volume 3, Part A, 4.20 and 4.21 state that the request must
be initiated on the Slave side and the response must be initiated on
the Master (the 0x0013 hints that lecup is sending a response, but I
may be mistaken). I may be getting confused with terms, so I'll just
ask:

How do I initiate a Connection Update from the peripheral? If this
isn't possible, how to I dictate the connection parameters (the
current connection is much too slow)?

Thanks,
Sandy

-- 

