Return-Path: <cyrus@holtmann.org>
Message-ID: <4EBBFE31.1060909@codeaurora.org>
Date: Thu, 10 Nov 2011 08:39:13 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: IO Capabilities, Secure Simple Pairing, and LE-SMP
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi All,

I am in the process of reimplementing my MITM patches for SMP, starting 
with some MGMT changes currently being uploaded here.

One of the issues that we need to agree on is the handling of IO 
Capabilities.  Others (Andrei) have already mentioned the "magic 
numbers" these currently exist as, but there is actually a larger issue, 
which I believe can be handled in one of two ways.

While BR/EDR based SSP defines 4 IO_Capabilities (DisplayOnly, 
DisplayYesNo, KeyboardOnly, and NoInputNoOutput), LE-SMP defines 5. The 
first four are the same as the SSP defines, the fifth one is critical to 
the support of MITM security, and is KeyboardDisplay.

This new IO capability is required for SMP MITM protection, because at 
least One of the two devices needs to be able to enter 6 digit numeric 
passkeys, and unless we always want to claim to be keyboards only (I 
would argue NO) then KeyboadDisplay is the logical choice for most full 
featured linux platforms.

Therefore I would like to gage the opinions of the group on two (or 
more) options:

1. Define separate LE and BR/EDR IO_Capabilities, and store them 
seperately in the hci_dev structure.  This would involve some further 
MGMT mods to specify BR vs LE io_caps, although the MGMT_OP_PAIR_DEVICE 
already includes an io_cap field that the user space could set on an 
explicit "Dedicated Bonding" initiation, it would not cover either 
"General Bonding", or remotely initiated bonding of any kind. Bluez 
would need to specify, and the kernel store, separate io_caps for each.

2. Internally map the KeyboardDisplay io_cap inside the kernel to 
DisplayYesNo for BR/EDR purposes.  This would allow higher level user 
space (bluez) entities to use a single io_cap (KeyboardDisplay), and 
have it automatically "fallback" to DisplayYesNo, which can be looked at 
as a subset of KeyboardDisplay.

Again, this is important, because without KeyboardDisplay, we will lose 
the ability to do MITM protection for many LE devices which may require 
it, and I would like to know opinions before I go too far down a path 
which may get shot down here.

My personal option is #2, because it involves code changes in the fewest 
places.

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
