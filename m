Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 27 Oct 2010 13:53:57 +0530
Message-ID: <AANLkTikzecKtx3ib-03n3f8_2u4KF0Y+PSmEJgccEg-i@mail.gmail.com>
Subject: [RFC] AVRCP 1.4 : Design proposal for future on Target Role
From: "shivendra.agrawal@stericsson.com" <ag.shivendra@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

ST-Ericsson plans to implement the commands to support target role of
AVRCP 1.4 Profile, and we would like to contribute it to BlueZ.
With our initial discussion, I would be aligning with BlueZ
contributors and would propose for the ideas that has not been
touched/developed so far, in order to have a design/implementation
that can be accepted.

As a very first, and very rough, design proposal for the BlueZ parts:
- A new SDP record for AVRCP 1.4 would be added to inform CT of the
version and features supported by target.
- A new callback to accept browsing channel establishment.
- Enhancing similar to bt_io_listen for browsing PSM.
- A new browsing command handler
- Incremental addition to AVRCP 1.4 commands.

Any feedback is very much appreciated!

Ref: Previous discussion subject: "AVRCP 1.4 : Future on Target Role"

Regards,
Shivendra
