Return-Path: <SRS0=OFBO=AG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081BBC433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Jun 2020 14:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D67B520768
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Jun 2020 14:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405497AbgFYOxq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Jun 2020 10:53:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405405AbgFYOxq (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Jun 2020 10:53:46 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 207629] BISECTED Bluetooth: hci0: command 0x2042 tx timeout -
 suspend fails - Dell XPS 9300, Dell XPS 7390, Dell Inspiron 7386, Intel
 NUC7JYB
Date:   Thu, 25 Jun 2020 14:53:45 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: todd.e.brandt@linux.intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-207629-62941-0zUmH3g5X4@https.bugzilla.kernel.org/>
In-Reply-To: <bug-207629-62941@https.bugzilla.kernel.org/>
References: <bug-207629-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=207629

--- Comment #24 from Todd Brandt (todd.e.brandt@linux.intel.com) ---
Here's a comprehensive list of all the machines in our power lab that are
seeing this issue. It started in 5.7.0-rc1:

5.7.0-rc1+      otcpl-dell-7386-whl     freeze-x4344    3892    89.59%
5.7.0-rc1+      otcpl-nuc-kbl           freeze-x984     850     86.38%
5.7.0-rc1+      lenb-Dell-XPS-13-9300   freeze-x607     359     59.14%
5.7.0-rc2+      otcpl-dell-7386-whl     freeze-x4341    3850    88.69%
5.7.0-rc2+      otcpl-cml-u             freeze-x2070    1797    86.81%
5.7.0-rc2+      otcpl-nuc-kbl           freeze-x3697    3164    85.58%
5.7.0-rc2+      lenb-Dell-XPS-13-9300   freeze-x402     214     53.23%
5.7.0-rc3+      otcpl-cml-u             freeze-x4020    3667    91.22%
5.7.0-rc3+      otcpl-dell-7386-whl     freeze-x4404    3979    90.35%
5.7.0-rc3+      otcpl-nuc-kbl           freeze-x3777    3288    87.05%
5.7.0-rc3+      lenb-Dell-XPS-13-9300   freeze-x612     359     58.66%
5.7.0-rc4+      otcpl-cml-u             freeze-x3460    3185    92.05%
5.7.0-rc4+      otcpl-dell-7386-whl     freeze-x3547    3261    91.94%
5.7.0-rc4+      otcpl-nuc-kbl           freeze-x3207    2821    87.96%
5.7.0-rc4+      otcpl-dell-7390-cmlu    freeze-x2879    2275    79.02%
5.7.0-rc4+      lenb-Dell-XPS-13-9300   freeze-x2426    1429    58.90%
5.7.0-rc4+      lenb-Dell-XPS-13-9300   freeze-x931     487     52.31%
5.7.0-rc5+      otcpl-nuc-kbl           freeze-x3254    2950    90.66%
5.7.0-rc5+      otcpl-dell-7386-whl     freeze-x3769    3400    90.21%
5.7.0-rc5+      otcpl-cml-u             freeze-x551     479     86.93%
5.7.0-rc5+      otcpl-dell-3493-icl     freeze-x3628    2992    82.47%
5.7.0-rc5+      otcpl-cml-s-1           freeze-x2949    1675    56.80%
5.7.0-rc5+      lenb-Dell-XPS-13-9300   freeze-x20      11      55.00%
5.7.0-rc6+      otcpl-dell-7386-whl     freeze-x3762    3417    90.83%
5.7.0-rc6+      otcpl-cml-u             freeze-x2420    2181    90.12%
5.7.0-rc6+      otcpl-nuc-glk           freeze-x1049    881     83.98%
5.7.0-rc6+      otcpl-cml-s-1           freeze-x2862    1581    55.24%
5.7.0-rc7+      otcpl-dell-7386-whl     freeze-x3818    3529    92.43%
5.7.0-rc7+      otcpl-nuc-glk           freeze-x3101    2637    85.04%
5.7.0-rc7+      otcpl-dell-7390-cmlu    freeze-x2971    2508    84.42%
5.7.0-rc7+      otcpl-cml-s-1           freeze-x1958    1649    84.22%
5.7.0-rc7+      otcpl-cml-s-2           freeze-x2920    1634    55.96%
5.7.0+          otcpl-dell-7386-whl     freeze-x3836    3550    92.54%
5.7.0+          otcpl-dell-7386-whl     freeze-x3804    3499    91.98%
5.7.0+          otcpl-cml-u             freeze-x1145    1044    91.18%
5.7.0+          otcpl-nuc-glk           freeze-x3160    2815    89.08%
5.7.0+          otcpl-nuc-glk           freeze-x3247    2854    87.90%
5.7.0+          otcpl-dell-7390-cmlu    freeze-x2966    2530    85.30%
5.7.0+          otcpl-dell-7390-cmlu    freeze-x2911    2395    82.27%
5.7.0+          otcpl-cml-s-2           freeze-x2879    1619    56.23%

-- 
You are receiving this mail because:
You are the assignee for the bug.
