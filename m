Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/3] Basic attribute permission support
Date: Wed,  1 Dec 2010 12:13:03 -0400
Message-Id: <1291219986-29913-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

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
* On BR/EDR, link encryption needs to be done "on the fly" before resending the
  failed ATT request.

Albeit the above issues, we believe these patches are ready for commit.

Regards,
--
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil

