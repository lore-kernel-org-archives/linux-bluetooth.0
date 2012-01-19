Return-Path: <cyrus@holtmann.org>
Message-ID: <4F175FC1.3060403@codeaurora.org>
Date: Wed, 18 Jan 2012 16:11:45 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: uuid_t and bt_uuid_t
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Can anybody tell me why we have to almost-but-not-quite equivalent 
storage mechanisms for UUIDs in (user-space) BlueZ?  This is accompanied 
by multiple sets of utilities as well.  It looks like one is targeting 
SDP and one isn't.  However, I need to occasionally translate from one 
form to the other.

They both include a "type" which is a u8 in one instance, and an enum in 
the other.  And then they both include a union for the u16, u32 and u128.

Is one suppose to be in network order, and the other native?  I can't 
tell just from looking at the various usages.

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
