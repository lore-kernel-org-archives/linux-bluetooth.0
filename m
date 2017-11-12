Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@kernel.org
Subject: [Bug 197855] New: btbcm can use uninitialized stack fw_name to try &
 report firmware
Date: Sun, 12 Nov 2017 01:07:29 +0000
Message-ID: <bug-197855-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=197855

            Bug ID: 197855
           Summary: btbcm can use uninitialized stack fw_name to try &
                    report firmware
           Product: Drivers
           Version: 2.5
    Kernel Version: <=4.14-rc8
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: mahatma@bspu.unibel.by
        Regression: No

Created attachment 260623
  --> https://bugzilla.kernel.org/attachment.cgi?id=260623&action=edit
pre-init fw_name in btbcm_initialize by hw id

btbcm can use uninitialized stack fw_name to try & report firmware. fw_name
first declared in hci_bcm.c bcm_setup(), must be filled in btbcm.c
btbcm_initialize().

Real hw: Lenovo Thinkpad 10 2nd, device BCM4354A2, uart. It defined later for
USB, but IMHO in this tablet it assembled on different wifi/bt/buses
combination, so calling uart from btattach cause messages like "BCM: Patch ...
not found", where "..." random stack garbage. I solve this problem by simple
init fw_name in btbcm.c. Unsure about style of this patch (it can cause too
agnostic silent firmware usage on new devices), but it just work for my device
- after googling & renaming BCM4354A2.hcd to BCM-unknown-uart-230f-2.hcd, so I
even don't try to add & report device ID to bcm_uart_subver_table (like
bcm_usb_subver_table).

PS I don't deep analyze a bit changed linux-next, but quick looks same (patch
fuzzy applied). Patch for 4.14.rc8. Also I don't check btbcm_setup_patchram()
for same problem.

-- 
You are receiving this mail because:
You are the assignee for the bug.