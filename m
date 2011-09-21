Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 0/3] More attribute allocation fixes
Date: Tue, 20 Sep 2011 22:49:08 -0400
Message-Id: <1316573351-30884-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Since the commit "Fix allocation of attribute values" I submitted last week
(which was authored by Vinicius), we found a few other issues related to
attribute allocation (thanks to Hendrik Sattler for the review of that commit,
BTW). This series fixes those issues. The last commit replaces a few memcpy()
operations with assignments, as suggested by Hendrik.

The allocation fixes have been tested with valgrind to make sure there are no
obvious leaks.

Best Regards,
--
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
