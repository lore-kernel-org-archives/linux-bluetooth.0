Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@kernel.org
Subject: [Bug 199125] New: Suspending to mem hangs the machine without the BT
 driver loaded
Date: Thu, 15 Mar 2018 09:29:32 +0000
Message-ID: <bug-199125-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=199125

            Bug ID: 199125
           Summary: Suspending to mem hangs the machine without the BT
                    driver loaded
           Product: Drivers
           Version: 2.5
    Kernel Version: 4.16.0-rc5
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: imre.deak@intel.com
        Regression: No

On an Intel GLK NUC machine suspending to memory (S3) hangs if the BT driver is
not enabled. Specifically the following kconfig options need to be enabled to
avoid the hang:

CONFIG_BT
CONFIG_BT_INTEL
CONFIG_BT_HCIBTUSB

An alternative is to disable the Bluetooth onboard device in BIOS.

The hang happens after execution transfers to BIOS code during suspend, after
the very last ACPI register write to entry S3 in
drivers/acpi/acpica/hwsleep.c:

after the following call in acpi_hw_legacy_sleep():
/* Write #2: Write both SLP_TYP + SLP_EN */                                     
        status = acpi_hw_write_pm1_control(pm1a_control, pm1b_control); 

In general not loading the BT driver may be a useful thing to work-around
potential BT driver bugs, or during isolation of a bug without a known reason
(by unloading drivers one-by-one and seeing if the problem re-occurs).

-- 
You are receiving this mail because:
You are the assignee for the bug.