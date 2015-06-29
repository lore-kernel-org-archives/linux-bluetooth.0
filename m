Return-Path: <cyrus@holtmann.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 81821] btusb logs error drivers/base/firmware_class.c:1105
 _request_firmware+0x431/0x7b0()
Date: Mon, 29 Jun 2015 08:00:26 +0000
Message-ID: <bug-81821-62941-iiqlXuqIgp@https.bugzilla.kernel.org/>
In-Reply-To: <bug-81821-62941@https.bugzilla.kernel.org/>
References: <bug-81821-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=81821

--- Comment #10 from Michael Lipp <mnl@mnl.de> ---
> I converted this firmware from the origin Windows-Driver for a Lenovo
> ThinkPad X230.

Nice approach, thanks. But this is not something for the "casual" user. I think
we must still get rid of the error message.

My problem isn't with Bluetooth (it work fine without the patch). It's the fact
that this error masks all subsequent kernel errors. Due to this being an error
(although it really isn't) my kernel gets "tainted" and the reporting of
subsequent problems (the ones that really matter to me) is turned off.

-- 
You are receiving this mail because:
You are the assignee for the bug.
