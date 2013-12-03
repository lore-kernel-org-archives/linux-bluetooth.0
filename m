Return-Path: <cyrus@holtmann.org>
From: Timo Mueller <mail@timomueller.eu>
To: linux-bluetooth@vger.kernel.org
Cc: Timo Mueller <timo.mueller@bmw-carit.de>
Subject: [PATCHv1 0/2] Introduce default adapter property
Date: Tue,  3 Dec 2013 16:21:44 +0100
Message-Id: <cover.1386078490.git.timo.mueller@bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Timo Mueller <timo.mueller@bmw-carit.de>

Hi,

the information about the default adapter is currently not available
through the D-Bus API of BlueZ. But as plugins can use this
information to choose the adapter they act upon it would be helpful
for users to be able to retrieve this information as well.

For example the neard plugin uses this information to decide for which
adapter oob data is generated. Users could use the same information to
power the adapter before actually sending the oob data.

Best regards,
Timo

Timo Mueller (2):
  doc: Introduce default adapter property
  adapter: Introduce default adapter property

 doc/adapter-api.txt |  9 +++++++++
 src/adapter.c       | 15 +++++++++++++++
 2 files changed, 24 insertions(+)

-- 
1.8.3.1

