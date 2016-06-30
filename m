Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Don Zickus <dzickus@redhat.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.von.dentz@intel.com, mkasik@redhat.com,
	Don Zickus <dzickus@redhat.com>
Subject: [PATCH 0/3] obexd fixes
Date: Thu, 30 Jun 2016 17:01:26 -0400
Message-Id: <1467320489-127890-1-git-send-email-dzickus@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We started running some obexd tests to help mimic Fedora users passing info
from their phone to their laptop.  These tests uncovered some issues.

Let me know if I need to fix these patches or try something different.

Cheers,
Don

Don Zickus (3):
  obexd: Allow CreateFolder to create a directory
  obexd: Return dummy_data instead of int in phonebook-dummy
  obexd: Add a detailed failure message for exchanging business cards

 obexd/client/opp.c              |  2 +-
 obexd/plugins/ftp.c             |  2 ++
 obexd/plugins/phonebook-dummy.c | 11 +++++++----
 3 files changed, 10 insertions(+), 5 deletions(-)

-- 
1.8.3.1

