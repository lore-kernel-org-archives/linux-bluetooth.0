Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v0 0/2] gdbus introspection fixes
Date: Fri, 14 Jan 2011 16:14:19 +0100
Message-Id: <1295018061-5849-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

Hi Johan,

During some connman debug session I found some small hickups in the
introspection code in gdbus. Marcel ask me to check with you first.

cheers,
daniel

Daniel Wagner (2):
  gdbus: invaldate_parent_data: walk the whole path down
  gdbus: Remove root node 'name' attribute in introspection

 gdbus/object.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

-- 
1.7.3.4

