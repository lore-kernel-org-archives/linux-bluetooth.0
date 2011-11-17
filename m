Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Nov 2011 13:53:45 +0100
From: Cedric Sodhi <manday@gmx.net>
To: linux-bluetooth@vger.kernel.org
Subject: Possible Regression: Frequent kernel panic with AR3011
Message-ID: <20111117125345.GC6237@slate>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From 3.1.0-gentoo to 3.2.*-* I start getting frequent kernel panics
which, at least from the dump, appear to be originating at ath_... - and
since the only atheros in my kernel is bluetooth, I very much assume
this is related to bluetooth. As soon as I could get a complete dump, I
will provide it. The device is 0cf3:3005 on USB.
