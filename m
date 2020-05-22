Return-Path: <SRS0=Rzh7=7E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CBDC433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 02:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EED8B207E8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 02:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgEVC4y convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 May 2020 22:56:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:60576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727050AbgEVC4y (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 May 2020 22:56:54 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 207843] New: Some ACPI discovered BRCM HCI UART chip write
 clock failed.
Date:   Fri, 22 May 2020 02:56:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: zechfox@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-207843-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=207843

            Bug ID: 207843
           Summary: Some ACPI discovered BRCM HCI UART chip write clock
                    failed.
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.6.13
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: low
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: zechfox@gmail.com
        Regression: No

Created attachment 289213
  --> https://bugzilla.kernel.org/attachment.cgi?id=289213&action=edit
dmesg output

>Overview:
>>My tablet uses AP6255 wifi/bluetooth module with BCM43455 chip.
>>The bluetooth controller worked well except bluetooth headset play sound
>>glitch.It's not configuration problem in bluez or pulseaudio.
>>Some log in dmesg indicated that baud rate was not correctly configured. 
>>dmesg:
>>>Bluetooth: BCM: failed to write clock (-56)
>>>Bluetooth: Failed to set baudrate.

>Steps to Reproduce:
>>1. Power on bluetooth headset.
>>2. If it was not automatically connect, connect to headset by bluetoothctl.
>>3. play sound.
>Actual Results:
>>sound glitches.
>Expect Results:
>>sound well.
>Additional Information: 
>>I suspect the baud rate was too low to transmit audio.
>>It seems the chip can't support write clock HCI command. Then bluetooth
>>driver used default 115200 baud rate.
>>I tried to force configure 4Mbps baud rate to my chip after write clock
>>failed, but reset it failed.  Then I hardcode baud rate to 3Mbps, it solved
>>the glitch problem. 
>>And I found the commit that introduced the 4Mbsp to ACPI device:
>>https://github.com/torvalds/linux/commit/74183a1c50a3c61e62d2e585107ea3c0b942a3ff
>>It seems not all ACPI discovered devices can support write clock.
>>So maybe the driver should fallback baud rate to 3Mbps if write clock failed.

-- 
Smiles ^__________^ zech

-- 
You are receiving this mail because:
You are the assignee for the bug.
