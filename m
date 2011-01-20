Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: vinicius.gomes@openbossa.org, claudio.takahasi@openbossa.org,
	johan.hedberg@nokia.com, padovan@profusion.mobi
Subject: [PATCH 0/1] Fix incoming attrib-server connection MTUs
Date: Thu, 20 Jan 2011 11:09:00 -0800
Message-Id: <1295550541-30535-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


This patch fixes bug detected by Johan.

The reworked patch passes a user_data argument to the bt_io_listen
call which identifies the server IO channel (le_io or l2cap_io). This
is propegated to the eventual connect_event, and used to set up the
correct default MTU for the underlying RF carrier channel.

As stated in the previous patches, this default MTU is important when
reading long Attributes, because some/most remote GATT clients assume
completion of an Attribute read when a shorter-than-MTU result is returned,
making it important for the server to completely fill the response
packets when possible.

--
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
