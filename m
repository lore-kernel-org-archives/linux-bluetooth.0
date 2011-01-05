Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
Cc: claudio.takahasi@openbossa.org, padovan@profusion.mobi,
	rshaffer@codeaurora.org, linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/2] Implement Compound GATT Procedures and Long Reads
Date: Tue,  4 Jan 2011 16:01:36 -0800
Message-Id: <1294185698-1499-1-git-send-email-bgix@codeaurora.org>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These two patches implement Compound GATT procedures, so that they
are executed atomically, and in the order that they are invoked,
regardless of whether they can be performed in a single or multiple
ATT Req/Resp transaction.

Patch 1 adds an ID parameter to g_attrib_send which shall be Zero for the
first ATT transaction, and shall be the previously returned ID for all
subsequent ATT transactions for that GATT procedure.  The underlying
code will enqueue the requested pkt at the Tail of the queue for Zero
ID'd pkts, and at the Head of the queue for non-zero (continuation)
pkts. The queue is then only services (next item sent) after the
callbacks have been made, to allow any continuation pkts to be created.


Patch 2 then uses this new feature of g_attrib_send to implement
support for Long Attribute Reads (using READ_BLOB).



-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
