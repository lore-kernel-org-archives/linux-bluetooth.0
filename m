Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@kernel.org
Subject: [Bug 198043] Bluetooth mgmt api set powered causes kernel race
 condition
Date: Wed, 17 Jan 2018 13:11:59 +0000
Message-ID: <bug-198043-62941-OUr1VxBPIG@https.bugzilla.kernel.org/>
In-Reply-To: <bug-198043-62941@https.bugzilla.kernel.org/>
References: <bug-198043-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=198043

--- Comment #2 from luc (l.perneel@luperco.com) ---
OK found the cause, but it is solved in the upcoming 4.15 kernel.
Patch can be found in:
https://patchwork.kernel.org/patch/9963977/

In short: the  function hci_send_monitor_ctrl_event (in hci_sock.c) takes the
read_lock.
Then it calls hci_send_to_channel which also takes the read_lock.
If now between the two read lock takes, a write lock is entered on another cpu
(and thus the waiting writer flag is set), the second take will decrease again
its counter (not entering the lock) and wait until the writer finished.
However, as the same thread took it already, it will never decrease to zero.
At the end both cpus are spinlocking waiting on each other for ever.
On a dual core system, this actually means you are dead.
(in fact you loose two cores when this happen on whatever system, and each next
bluetooth request can lockup another core until the system is dead).

I will fix my 4.9 kernel, but I hope this nasty bug is backported towards older
kernels.

-- 
You are receiving this mail because:
You are the assignee for the bug.