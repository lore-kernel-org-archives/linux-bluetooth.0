Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH RFC BlueZ 0/5] Time Profile (server) improvements
Date: Fri,  2 Dec 2011 14:34:05 -0400
Message-Id: <1322850850-18019-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This series implements two new features for GATT Time Profile (server role):

* Reference Time Update Service (RTUS), with two drivers (called "providers"
  here): dummy (for testing) and timed (for N9/harmattan)
* Support for current time notifications

We are aware of the current plan of moving platform specific code out of BlueZ
(to agents communicating over D-Bus). Is it feasible to be done now for GATT
servers as well?

Comments are welcome.

Best Regards,
--
Anderson Lizardo
Instituto Nokia de Tecnologia (INdT)
Manaus - Brazil
