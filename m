Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 0/1] Bluetooth: Add LE Data signing smp_sign_pkt()
Date: Fri, 16 Dec 2011 14:40:48 -0800
Message-Id: <1324075249-5755-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is in response to Sumit's inquiry yesterday.

This patch impliments data signing as perscribed in:
1. BT Core Spec v4.0 Vol 3 Part H Sec 2.4.5
2. RFC-4493
3. BT Erratum 4243

It has been verified against the sample data described in Erratum 4243.

Nobody calls this code at this point, and SMP does not yet exchange CSRK's,
but I am working on it.  There has been much debate on Data signing in the
Core Systems Working Group and at UPFs, but it is finally coming to a
resolution, and the code here is what I believe to be correct.

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum 
