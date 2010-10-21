Return-Path: <cyrus@holtmann.org>
From: Ingvar PALSSON <ingvar.palsson@stericsson.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Thu, 21 Oct 2010 15:55:18 +0200
Subject: Hands-Free Profile 1.6 + Wide Band Speech
Message-ID: <8D1D76E2AA70144DA189F3EC6BDCC4184F214E4B57@EXDCVYMBSTM006.EQ1STM.local>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

ST-Ericsson plans to implement support for Hands-Free Profile 1.6 including Wide Band Speech, and we would like to contribute it to BlueZ.
We are not aware of any ongoing work within BlueZ on HFP 1.6, but would like to cooperate in order to have a design/implementation that can be accepted.

As a very first, and very rough, design proposal for the BlueZ parts in kernel can be mentioned:
- A new (SCO) socket option is used (set by HF control layer in user space prior to connect) in order to indicate that a transparent eSCO link is required.
- PCM/I2S or similar is used to transfer the 16kHz audio to the BT Controller. We have no intention to use HCI for 16 kHz eSCO. I.e. the mSBC codec must be integrated in the Controller (there is however nothing in the design that prevents HCI from being used for SCO data at a later stage if someone wishes to implement it).

Any feedback is very much appreciated!

Kind regards,
/Ingvar



