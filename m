Return-Path: <cyrus@holtmann.org>
Message-ID: <4D508DC2.60003@codeaurora.org>
Date: Mon, 07 Feb 2011 16:26:42 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org, vinicius.gomes@openbossa.org
Subject: Frequent SM test failure at UPF
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Testing of Shorter than 16 octet keys.

In smp_cmd_pairing_random() when the STK is generated, it needs to be 
truncated to the MIN of conn->preq[4] and conn->pres[4].

This Min value may need to be saved for later as well, because it needs 
to also limit the LTK key exchange.

This failure showed up with the PTS tool, and at least one other device 
during the days testing.  I have mocked up a fix, but have not had a 
chance to test it yet.


-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
