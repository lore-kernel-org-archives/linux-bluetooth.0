Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/2] obexd: Add support for retrieving messages in fractions
Date: Thu, 28 Feb 2013 16:08:42 +0100
Message-Id: <1362064124-29787-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

The MAP specification allows the client to retrieve messages in fractions,
if the complete message is not yet available on the server.

In case of some push-email services, the first fraction is available
on the phone and can be downloaded immediately. Further fractions or
attachments might not be available and have to be downloaded from the
network first.

In order to extend org.bluez.obex.Message1.Get with a FractionRequest
parameter, I have moved the currently existing parameter Attachment
into an args dict and made it optional (defaulting to true).
How are such interface changes handled in BlueZ 5? Should I increment
the interface version number as well? Or is that done with the next
release?

Christian Fetzer (2):
  obexd: Move Message.Get parameter attachment into dictionary
  obexd: Add support for retrieving messages in fractions

 doc/obex-api.txt   |  22 +++++++-
 obexd/client/map.c | 161 +++++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 170 insertions(+), 13 deletions(-)

-- 
1.8.1.4

