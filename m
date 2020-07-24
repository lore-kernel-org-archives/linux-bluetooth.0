Return-Path: <SRS0=QcUl=BD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DE2C433E4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Jul 2020 15:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C78B206D8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Jul 2020 15:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgGXPq4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Jul 2020 11:46:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgGXPq4 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Jul 2020 11:46:56 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Fri, 24 Jul 2020 15:46:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: albin.linux-kernel@kauff.org
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-c62QY3zQmo@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=60824

--- Comment #110 from Albin Kauffmann (albin.linux-kernel@kauff.org) ---
Oh, I should have added that btmon gives me the following error when plugging
the USB dongle:

< HCI Command: Read Current IAC LAP (0x03|0x0039) plen 0                       
                                                                               
                                                        #21 [hci0] 39.239547
> HCI Event: Command Complete (0x0e) plen 8                                    
>                                                                              
>                                                           #22 [hci0]
> 39.241502
      Read Current IAC LAP (0x03|0x0039) ncmd 1
        Status: Success (0x00)
        Number of IAC: 1
        Access code: 0x9e8b33 (General Inquiry)
< HCI Command: Set Event Filter (0x03|0x0005) plen 1                           
                                                                               
                                                        #23 [hci0] 39.241510
        Type: Clear All Filters (0x00)
> HCI Event: Command Complete (0x0e) plen 4                                    
>                                                                              
>                                                           #24 [hci0]
> 39.243501
      Set Event Filter (0x03|0x0005) ncmd 1
        Status: Invalid HCI Command Parameters (0x12)
= Close Index: 00:1A:7D:DA:71:12

-- 
You are receiving this mail because:
You are the assignee for the bug.
