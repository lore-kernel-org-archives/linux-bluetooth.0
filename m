Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCHv3 14/15] android: Add makefile for hciconfig
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20131014115131.GG2861@aemeltch-MOBL1>
Date: Mon, 14 Oct 2013 14:06:11 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <863CEBAE-1469-4E15-A90A-ED373C614FAB@holtmann.org>
References: <1381131496-9417-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1381243883-2745-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1381243883-2745-15-git-send-email-Andrei.Emeltchenko.news@gmail.com> <60443344-0A54-4EF4-ABBB-1EAAE168E541@holtmann.org> <20131014115131.GG2861@aemeltch-MOBL1>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

>>> 
>>> ---
>>> android/Android.mk |   34 ++++++++++++++++++++++++++++++++++
>>> 1 file changed, 34 insertions(+)
>>> 
>>> diff --git a/android/Android.mk b/android/Android.mk
>>> index e7a70d0..09c4579 100644
>>> --- a/android/Android.mk
>>> +++ b/android/Android.mk
>>> @@ -123,3 +123,37 @@ $(foreach file,$(lib_headers), $(shell ln -sf ../$(file) $(LOCAL_PATH)/../lib/bl
>>> LOCAL_MODULE := libbluetooth
>>> 
>>> include $(BUILD_SHARED_LIBRARY)
>>> +
>>> +#
>>> +# hciconfig
>>> +#
>> 
>> why are we building this one. Only btmgmt should be needed for testing. If at all.
>> 
> 
> Can btmon now save packet dump in a format understandable for wireshark?

btmon stores in the new BTSnoop format that allows for multiple controllers in the same trace. If Wireshark does not support these, then that should be fixed in Wireshark.

Regards

Marcel

