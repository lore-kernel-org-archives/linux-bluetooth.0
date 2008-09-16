Return-Path: <cyrus@holtmann.org>
Date: Tue, 16 Sep 2008 15:51:23 -0700 (PDT)
Message-Id: <20080916.155123.181085856.davem@davemloft.net>
To: marcel@holtmann.org
CC: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: btusb suspend/resume bug...
From: David Miller <davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>


Marcel, others, please bring some kind of closure to this
regression list entry:

Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=11442
Subject		: btusb hibernation/suspend breakage in current -git
Submitter	: Rafael J. Wysocki <rjw@sisk.pl>
Date		: 2008-08-25 11:37 (19 days old)
References	: http://marc.info/?l=linux-bluetooth&m=121966402012074&w=4
Handled-By	: Oliver Neukum <oliver@neukum.org>
Patch		: http://marc.info/?l=linux-bluetooth&m=121967226027323&w=4

There is a patch, it is tested, so the only course of action at
this point is to merge the fix or declare that this really isn't
a regression.

My impression is the later, because the driver btusb is replacing
doesn't handle suspend/resume either.  Isn't that right?
