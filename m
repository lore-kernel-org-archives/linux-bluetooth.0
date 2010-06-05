Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org
Subject: Fixes issues reported by Smatch static checker
Date: Sat,  5 Jun 2010 07:14:27 -0300
Message-Id: <1275732870-15889-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Issues found by smatch static check: http://smatch.sourceforge.net/

There are still 3 critical issues:

src/storage.c +773 write_trust(29) error: we previously assumed 'match' could be null.
lib/sdp.c +2052 sdp_get_lang_attr(16) warn: variable dereferenced before check 'pEncoding'
lib/sdp.c +2067 sdp_get_lang_attr(31) error: we previously assumed 'pOffset' could be null.


