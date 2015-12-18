Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 100461] No BCM43341 uart support on T100TAF
Date: Fri, 18 Dec 2015 08:19:34 +0000
Message-ID: <bug-100461-62941-mrZ0cUZdeG@https.bugzilla.kernel.org/>
In-Reply-To: <bug-100461-62941@https.bugzilla.kernel.org/>
References: <bug-100461-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=100461

--- Comment #3 from Luka Karinja <luka.karinja@gmail.com> ---
after reinstal bluez 5.36 the bluetooth works like it should.

Anyone looking to get the T100TAF bluetooth working just need to add BCM2E65 to
hci_bcm.c

-- 
You are receiving this mail because:
You are the assignee for the bug.
