Return-Path: <cyrus@holtmann.org>
Message-ID: <572595.91160.qm@web94916.mail.in2.yahoo.com>
Date: Fri, 16 Apr 2010 00:55:58 +0530 (IST)
From: Pavan Savoy <pavan_savoy@yahoo.co.in>
Subject: killing stalled ACL connection
To: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I am working on a platform which has a very aggressive power management features.
So consider a situation, where an a2dp connection exists with a headset, and i pause the media over AVRCP, so my phone now goes into suspend state (shutting off UART clocks), 

and when I wake-up (resume) using the AVRCP connection, via the play/pause button, I see the platform waking up and media player receiving the input, However I also see this,

hci0  ACL tx timeout.
killing stalled ACL connection.

and media is not able to play on the headset anymore.
Although the media player thinks it's being played.

Now where should I look into, as to why a perfectly nice ACL (l2cap, a2dp) connection was dropped during the suspend ?



Send free SMS to your Friends on Mobile from your Yahoo! Messenger. Download Now! http://messenger.yahoo.com/download.php
