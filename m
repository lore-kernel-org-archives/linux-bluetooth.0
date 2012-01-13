Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Jan 2012 12:08:35 -0800 (PST)
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
cc: johan.hedberg@gmail.com, marcel@holtmann.org, skrovvid@codeaurora.org
Subject: As long as we're adding to the Device Connected mgmt event...
Message-ID: <alpine.DEB.2.02.1201131159420.24403@mathewm-linux>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>


Johan -

I noticed your recent bluez.git commit that modifies the Device 
Connected event.  Would it also make sense to add the results of the 
READ_REMOTE_VERSION command?

lmp_ver
manufacturer
lmp_subver

This information was captured in bluetoothd when using hciops, but has 
so far been missing with mgmtops.

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
