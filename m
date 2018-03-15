Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@kernel.org
Subject: [Bug 198953] hci_bcm: Streamline runtime PM code    change for 4.16
 kernel breaks bluetooth on ASUS T100TA
Date: Thu, 15 Mar 2018 20:01:45 +0000
Message-ID: <bug-198953-62941-5JiUM20b2t@https.bugzilla.kernel.org/>
In-Reply-To: <bug-198953-62941@https.bugzilla.kernel.org/>
References: <bug-198953-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=198953

--- Comment #20 from jbMacAZ (jbmacbrodie@yahoo.com) ---
Created attachment 274769
  --> https://bugzilla.kernel.org/attachment.cgi?id=274769&action=edit
acpidump for T100CHI

Attached is the acpidump for the T100CHI.  I've applied the three patches to
4.16-5c5 (the revert is still applied.)  Bluetooth still works on the T100CHI
through at least one BT timeout cycle.

Also, if there are other helpful patches for the T100*, please share them at
the T100/Ubuntu group!  It can take months for accepted patches to actually get
to the mainstream.

Thanks,
John

-- 
You are receiving this mail because:
You are the assignee for the bug.