Return-Path: <cyrus@holtmann.org>
From: "Zheng, Wu" <wu.zheng@intel.com>
To: "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Use HFP as sco sink and source at the same time
Date: Mon, 20 Oct 2014 08:15:35 +0000
Message-ID: <2CF57A644018A745B8FE029C7223E16E11964A9B@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

HFP is used on IVI and meet some issues.

EXACT STEPS LEADING TO PROBLEM:
===========================================================
1. pair BT phone by bluetoothctl
2. launch dialer app
3. make voice call and answer, the voice can be heard from IVI speaker
4. pair and connect BT headset with bluetoothctl

EXPECTED OUTCOME:
===================
Voice send out from the BT headset
ACTUAL OUTCOME
===================
sound still heard from IVI speaker, doesn't auto switch to BT handset

I don't make sure if Bluez can support it or not?

Question: the SCOs connection of HFP on IVI can be used as SCO sink and source at the same time?

It is the issue of https://bugs.tizen.org/jira/browse/TC-160.

Thanks.

Best Regards
Zheng Wu
