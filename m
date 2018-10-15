Return-Path: <SRS0=/MJP=M3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E69C28CF8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Oct 2018 08:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76F42064E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Oct 2018 08:43:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E76F42064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbeJOQ1a convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Oct 2018 12:27:30 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:60178 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726319AbeJOQ1a (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Oct 2018 12:27:30 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 66C2029624
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Oct 2018 08:43:12 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 64F842963F; Mon, 15 Oct 2018 08:43:12 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 200039] BT advertising packet wakes up the system from S3 and
 suspend-to-idle
Date:   Mon, 15 Oct 2018 08:43:12 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: raghuram.hegde@intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-200039-62941-AmGiAIX1CQ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-200039-62941@https.bugzilla.kernel.org/>
References: <bug-200039-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=200039

--- Comment #19 from Raghuram Hegde (raghuram.hegde@intel.com) ---

Thanks for the sharing complete btmon logs.
As evident from the below log snippet, once the remote device is disconnected,
the host will start a Passive scan. The filter policy is set to "Accept all
advertisement" as the previously paired device in the White List (Designer
Mouse) has random address:

< HCI Command: Disconnect (0x01|0x0006) plen 3            #159 [hci0] 19.853664
        Handle: 3585
        Reason: Remote User Terminated Connection (0x13)
> HCI Event: Command Status (0x0f) plen 4                 #160 [hci0] 19.855749
      Disconnect (0x01|0x0006) ncmd 1
        Status: Success (0x00)
> HCI Event: Disconnect Complete (0x05) plen 4            #161 [hci0] 19.903759
        Status: Success (0x00)
        Handle: 3585
        Reason: Connection Terminated By Local Host (0x16)
@ MGMT Event: Command Complete (0x0001) plen 10       {0x0001} [hci0] 19.903829
      Disconnect (0x0014) plen 7
        Status: Success (0x00)
        LE Address: DF:29:ED:8F:82:95 (Static)
@ MGMT Event: Device Disconnected (0x000c) plen 8     {0x0003} [hci0] 19.903852
        LE Address: DF:29:ED:8F:82:95 (Static)
        Reason: Connection terminated by local host (0x02)
@ MGMT Event: Device Disconnected (0x000c) plen 8     {0x0002} [hci0] 19.903852
        LE Address: DF:29:ED:8F:82:95 (Static)
        Reason: Connection terminated by local host (0x02)
< HCI Command: LE Set Scan Parame.. (0x08|0x000b) plen 7  #162 [hci0] 19.949197
        Type: Passive (0x00)
        Interval: 60.000 msec (0x0060)
        Window: 30.000 msec (0x0030)
        Own address type: Public (0x00)
        Filter policy: Accept all advertisement (0x00)
> HCI Event: Command Complete (0x0e) plen 4               #163 [hci0] 19.949798
      LE Set Scan Parameters (0x08|0x000b) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2    #164 [hci0] 19.949848
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4               #165 [hci0] 19.951759
      LE Set Scan Enable (0x08|0x000c) ncmd 2
        Status: Success (0x00)


Since, passive scan is going on when the system is put to suspend, the system
wakes up when any Advertisement report is received.

Thanks,
Raghu

-- 
You are receiving this mail because:
You are the assignee for the bug.
