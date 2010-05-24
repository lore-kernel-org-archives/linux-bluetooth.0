Return-Path: <cyrus@holtmann.org>
Message-ID: <4BFAEB5C.4040300@codeaurora.org>
Date: Mon, 24 May 2010 16:10:52 -0500
From: Ron Shaffer <rshaffer@codeaurora.org>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/1] Bluetooth: Synchronize SCO/eSCO connection requests to
 ACL state
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel:

This patch resolves some issues with what looks to be certain CSR
based headsets. When requesting SCO or eSCO while the connection
is transitioning from sniff to active, i.e. unsniff has been requested
but the headset has not responded with accepted, these headsets seem
to enter a state where they don't positively respond the SCO/eSCO
request. This was first noticed in and Motorola H350 Headset.

In addition, I've cleaned up some extraneous spaces and the original
Copyright has been changed from Qualcomm to Code Aurora Forum as
Qualcomm has reassigned these rights to Code Aurora Forum.

-- 
Ron Shaffer
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
