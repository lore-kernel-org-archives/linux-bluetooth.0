Return-Path: <cyrus@holtmann.org>
Subject: -DG_DISABLE_DEPRECATED and g_io_channel_*()
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 18 Jan 2011 11:08:23 -0800
Message-ID: <1295377703.1774.6.camel@ubuntuLab1>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

There appears to be a number of deprecated g_io_channel_* functions
being called from the bluez tip, which are breaking the build due to
Marcel's latest commit today:

commit effe770cd43cf53fa5842291941dbfc82beab645
Author: Marcel Holtmann <marcel@holtmann.org>
Date:   Tue Jan 18 14:56:31 2011 +0100

    Use -DG_DISABLE_DEPRECATED compiler define


Should this commit be backed out until these deprecated usages have been
fixed, or is this the general way that the issue is forced?

Obviously deprecated functions should not be used, but it creates an
unbuildable bluez in the meantime.

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

