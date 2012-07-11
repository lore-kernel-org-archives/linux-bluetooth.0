Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [RFC BlueZ] mgmt-api: Broadcaster/Observer management API
Date: Wed, 11 Jul 2012 17:34:47 -0300
Message-Id: <1342038888-10102-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This is a proposal for new Management API commands to allow implementing
Broadcaster/Observer roles in BlueZ. It can also be used to add information to
EIR on BR/EDR controllers.

Comments and suggestions are welcome. If anyone has a better name for the "Set
Controller Data" and "Remove Controller Data" commands (that are not LE
specific), let us know.


Anderson Lizardo (1):
  mgmt-api: Broadcaster/Observer management API

 doc/mgmt-api.txt |   70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

-- 
1.7.9.5

