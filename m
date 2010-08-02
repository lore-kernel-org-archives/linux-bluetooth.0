Return-Path: <cyrus@holtmann.org>
Message-ID: <1c6058affcf5b834ec33d0cd2bf43c61.squirrel@www.codeaurora.org>
Date: Mon, 2 Aug 2010 11:19:36 -0700 (PDT)
Subject: Question about a patch set that is comprised of patches for
     separate git repositories
From: ingas@codeaurora.org
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

I am planning on submitting a patch set for hcidump that allows parsing of
AMP related HCI commands and events. While the modification of parsing
code is constrained to bluez-hcidump git repository, the code relies on
changes to hci.h file that resides in bluez git repository. Basically, I
had to create new structures and defines for OCFs and attributes and hci.h
seemed like a logical place to do that. However, nothing else in bluez
subdirectory is referring those new structs and constants. So the question
is: do I have 2 separate submissions: one for bluez and the other for
hcidump noting that hcidump depends on the patch for hci.h in bluez, or do
I somehow generate a combined patch set?

Thank you,

Inga

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

