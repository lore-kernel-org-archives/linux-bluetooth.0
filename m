Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@kernel.org
Subject: [Bug 197121] Bluetooth regression "no bluetooth adapters found"
 Baytrail T100CHI (SDIO) BCM4324B3
Date: Tue, 03 Oct 2017 19:39:22 +0000
Message-ID: <bug-197121-62941-JjGem9SFMt@https.bugzilla.kernel.org/>
In-Reply-To: <bug-197121-62941@https.bugzilla.kernel.org/>
References: <bug-197121-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=197121

Loic Poulain (loic.poulain@linaro.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |loic.poulain@linaro.org

--- Comment #1 from Loic Poulain (loic.poulain@linaro.org) ---
Seems that you did not included BCM HCI UART protocol:
CONFIG_BT_HCIUART_BCM

This now depends on CONFIG_BT_HCIUART_SERDEV which depends on
CONFIG_SERIAL_DEV_BUS.

-- 
You are receiving this mail because:
You are the assignee for the bug.