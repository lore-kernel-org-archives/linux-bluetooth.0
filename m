Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 190831] Intel Bluetooth 8260 breaks with latest firmware
Date: Thu, 05 Jan 2017 14:44:20 +0000
Message-ID: <bug-190831-62941-OiokWhF4sp@https.bugzilla.kernel.org/>
In-Reply-To: <bug-190831-62941@https.bugzilla.kernel.org/>
References: <bug-190831-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=190831

--- Comment #11 from Marcin Kurek <morgoth6@gmail.com> ---
I can observe same symptoms as reporter on Precision 5510 with 8260 [8086:24f3]
(rev 3a) Bluetooth works with older version of firmware:

2010a4f3942b6df95ed928f92db3d000  ibt-11-5.ddc
2f06625d1cab8e6edb339dc7a0db4e91  ibt-11-5.sfi

With new version my mouse stops a seconds after connection. When I try to mix
old sdi and old ddc it seems to works, but the mouse pointer is jumpy as hell
and quite hard to use (but as mentioned the event mask error is not apear with
mixed versions)

I will try with attached one in a second and see.

-- 
You are receiving this mail because:
You are the assignee for the bug.
