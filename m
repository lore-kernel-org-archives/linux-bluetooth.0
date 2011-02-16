Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@nokia.com, padovan@profusion.mobi
Subject: [PATCH 0/3] Modifications composed during UPF38
Date: Wed, 16 Feb 2011 13:17:58 -0800
Message-Id: <1297891081-27976-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



The major change in these patches is to register Primary Services
into the SDP databases as required when registering them
into the attrib-server's database. The Core v4.0 specification
indicates that the only valid/foolproof way for a BR/EDR
client to query a server for Primary Services is to do so via
an SDP query. This is from Core v4.0, Vol 3, Part G, Sec 4.4:

"GATT service discovery over BR/EDR transport will list services that only run
over an LE transport and therefore only SDP service discovery shall be used
on BR/EDR."

This also means that there can be "LE Only" primary services that do NOT
need to be in the SDP database, so if a valid range is not specified
when registering a Primary Service, it will be omitted from SDP, and
only appear when performing a GATT based Primary Service Discover.

Also -- The ATT_UUID we were using was incorrect, and I extended the
functionality of the gatttool to allow for listening without sending
anything, and ability to perform both a char-write and char-cmd.


-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum 
