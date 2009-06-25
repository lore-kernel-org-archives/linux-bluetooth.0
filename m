Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <113d36d80906242033p134edf27t12bda1d0359c4134@mail.gmail.com>
References: <113d36d80906242033p134edf27t12bda1d0359c4134@mail.gmail.com>
Date: Thu, 25 Jun 2009 14:26:09 +0800
Message-ID: <113d36d80906242326g3f2ce8e3h6c779aa01d776b04@mail.gmail.com>
Subject: question on A2DP sink suspend/resume
From: lan zhu <zhu.lan.cn@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If we want to create SCO link when A2DP is in streaming state, we
shall suspend A2DP first and then establish SCO link. Conversely, we
shall resume A2DP link when we drop SCO link. The entire description
can be found in the Simultaneous use of HFP, A2DP, and AVRCP Profiles
Whitepaper on bluetooth org web site.
(https://www.bluetooth.org/Technical/Specifications/whitepapers.htm).

My question is,  I found there is no such sink_suspend or sink_resume
method in D-BUS API while these functions are all implemented in Bluez
audio module. I would like to know why don't put them to D-BUS API?
If we need to call these functions we have to expand the D-BUS API.

One more question is, is there a formal way to test SCO/A2DP
simultaneous case? we can't find a proper headset to test it because
those headsets are all well implemented with the simultaneous logic,
so there is no way to enter ourselves' code that handle this logic.
Can we test it by configurating some test tool such as PTS?


 Thanks,
 Zhu Lan
