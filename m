Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Subject: Re: [PATCH 2/3] android/hidhost: Remove deprecated idle opcode from ipc document
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <5281F502.9080506@linux.intel.com>
Date: Wed, 13 Nov 2013 00:57:43 +0900
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <CEAF8E5F-E4CE-4081-9870-4E4A802E9483@holtmann.org>
References: <1384172130-29837-1-git-send-email-ravikumar.veeramally@linux.intel.com> <1384172130-29837-2-git-send-email-ravikumar.veeramally@linux.intel.com> <0C266DD4-7034-4D43-ADEB-E05BE0E54B32@holtmann.org> <5281F502.9080506@linux.intel.com>
To: Ravi Kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

>>> Idle time is deprecated in HID 1_1. So remove it from ipc document
>>> and update GET_REPORT and VIRTUAL_UNPLUG opcode values.
>>> ---
>>> android/hal-ipc-api.txt | 10 ++--------
>>> android/hal-msg.h       |  4 ++--
>>> 2 files changed, 4 insertions(+), 10 deletions(-)
>>> 
>>> diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
>>> index 91ea280..57f4c13 100644
>>> --- a/android/hal-ipc-api.txt
>>> +++ b/android/hal-ipc-api.txt
>>> @@ -614,20 +614,14 @@ Notifications:
>>> 		                      0x01 = Boot
>>> 		                      0xff = Unsupported
>>> 
>>> -	Opcode 0x84 - Idle Time notification
>>> -
>>> -		Notification parameters: Remote address (6 octets)
>>> -		                         Status (1 octet)
>>> -		                         Idle time (2 octets)
>> so what does HID_1.1 actually mean? I still see this notification in bt_hh.h.
>> 
>> Regards
>> 
>> Marcel
>> 
> In  HID_SPEC_V11 (3.1) Get Idle and Set Idle are deprecated. And even in bt_hh.h
> get_idle and set_idle interfaces are not available. Bluedroid had implementation
> of those two in bluedroid/btif/src/btif_hh.c but in interface struct those are commented out.
> I didn't find the call back call there. That's why I updated ipc-doc.

if they are not using this notification in the Bluetooth service, then we do not need to implemented.

Regards

Marcel

