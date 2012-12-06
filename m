Return-Path: <cyrus@holtmann.org>
Message-ID: <1354827861.3394.5.camel@dellpc>
Subject: hidp bug concerning ctrl_sk sock
From: Karl Relton <karllinuxtest.relton@ntlworld.com>
To: linux-bluetooth@vger.kernel.org
Date: Thu, 06 Dec 2012 21:04:21 +0000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With reference to bug https://bugzilla.kernel.org/show_bug.cgi?id=50541
it seems to me that the hidp driver has a problem in the hidp_session()
function.

The sock structure pointed to by ctrl_sk is being freed from under the
functions feet (as far as I can see), causing this function to crash.
Shouldn't a lock_sock or sock_hold be necessary to keep the sock
structure around until hidp_session has finished with it?


