Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 0/3] Basic attribute permission support
Date: Fri,  3 Dec 2010 14:26:19 -0400
Message-Id: <1291400782-24736-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Changes since V1:

* Simplified permission scheme according to discussion on IRC.
* Fixed incorrect error sent by server.

This patchset adds initial support for attribute permission checks. Currently,
only access and authentication permissions are checked. Authorization
permissions require integration with the BlueZ agent, which is not implemented
yet.

There are some pending issues necessary for a minimum complete attribute
permission support (all of them are being worked on):

* The attribute client, upon receiving the "Insufficient Encryption" error,
  shall increase the security level and resend the failed request.
* The attribute server shall verify the connection permissions on each ATT
  request, and not just once on connection callback.
* On kernel side, increasing the security level (using setsockopt()) shall
  trigger SMP negotiation for a LE connection, blocking next socket I/O until
  negotiation is finished.
* On BR/EDR, link encryption is mandatory for GATT (see Vol 3, Part G, 2.4
  "Profile Fundamentals").

Albeit the above issues, we believe these patches are ready for commit.

Regards,
--
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil

