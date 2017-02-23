Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Ricardo Joaquinito <rjoaquinito@gmail.com>
Date: Thu, 23 Feb 2017 11:07:37 +0000
Message-ID: <CABcPTiSz8AHECwoJ9D3JKNG4j6cKn9Z4sG-chH5trgOnPvxTcA@mail.gmail.com>
Subject: Bluetooth OOB pairing using btmgmt
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi.

Is it possible to have Bluetooth BR/EDR Out-of-Band (OOB) pairing
using the btmgmt tool?
I used the local-oob and remote-oob commands between 2 Linux machines
(machines A and B). In machine A, I generate the Hash H_a and Random
R_a from "btmgmt local-oob" command and in machine B I use the same
command to generate the Hash H_b and Random R_b.

I configured machine A with

# btmgmt remote-oob -R R_b -C H_b machine_B_BT_address

and I configured machine B with

# btmgmt remote-oob -R R_a -C H_a machine_A_BT_address.

I then started the pairing in machine A and in machine B btmon shows
that machine A pairing request does not have OOB data flag on.
Maybe I am using OOB in a wrong way in this scenario. Can you tell me
how to establish an OOB pairing using this simple scenario?

Thank you and best regards,
Ricardo Joaquinito
