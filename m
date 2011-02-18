Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@nokia.com, padovan@profusion.mobi,
	anderson.lizardo@openbossa.org
Subject: [PATCH 0/1] SDP registration of Primary GATT Services
Date: Fri, 18 Feb 2011 12:11:37 -0800
Message-Id: <1298059898-27366-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


This addresses Anderson's issue with the SDP registration. It maintains
the prior APIs and adds a couple which can be called any time after
a complete Primary Service has been inserted into the attribute database.

This allows the attrib-server user to pick and choose the services he
wants to expose to BR/EDR devices, as opposed to LE only devices. It also
gives a mechanism to remove the SDP record from the SDP db.

It also has improved naming (attrib_*) to tie all the parts together.

--
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
