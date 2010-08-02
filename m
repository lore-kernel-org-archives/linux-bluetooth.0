Return-Path: <cyrus@holtmann.org>
Subject: Re: Question about a patch set that is comprised of patches for
 separate git repositories
From: Marcel Holtmann <marcel@holtmann.org>
To: ingas@codeaurora.org
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1c6058affcf5b834ec33d0cd2bf43c61.squirrel@www.codeaurora.org>
References: <1c6058affcf5b834ec33d0cd2bf43c61.squirrel@www.codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 02 Aug 2010 11:45:41 -0700
Message-ID: <1280774741.12579.23.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Inga,

> I am planning on submitting a patch set for hcidump that allows parsing of
> AMP related HCI commands and events. While the modification of parsing
> code is constrained to bluez-hcidump git repository, the code relies on
> changes to hci.h file that resides in bluez git repository. Basically, I
> had to create new structures and defines for OCFs and attributes and hci.h
> seemed like a logical place to do that. However, nothing else in bluez
> subdirectory is referring those new structs and constants. So the question
> is: do I have 2 separate submissions: one for bluez and the other for
> hcidump noting that hcidump depends on the patch for hci.h in bluez, or do
> I somehow generate a combined patch set?

send the patch for hci.h first. Then we see. The LE additions took like
a few rounds of review. So we do these first.

Regards

Marcel


