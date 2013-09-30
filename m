Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH] Bluetooth: Provide high speed configuration option
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20130929192209.GA1115@x220.p-661hnu-f1>
Date: Mon, 30 Sep 2013 05:20:23 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <BCBD79F7-CC67-41CC-94C6-94310172A422@holtmann.org>
References: <1380452005-7211-1-git-send-email-marcel@holtmann.org> <20130929192209.GA1115@x220.p-661hnu-f1>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -32,8 +32,6 @@
>> #include <net/bluetooth/mgmt.h>
>> #include <net/bluetooth/smp.h>
>> 
>> -bool enable_hs;
>> -
>> #define MGMT_VERSION	1
>> #define MGMT_REVISION	3
>> 
>> @@ -382,8 +380,7 @@ static u32 get_supported_settings(struct hci_dev *hdev)
>> 		settings |= MGMT_SETTING_LINK_SECURITY;
>> 	}
>> 
>> -	if (enable_hs)
>> -		settings |= MGMT_SETTING_HS;
>> +	settings |= MGMT_SETTING_HS;
> 
> I know it's a bug in the original code, but we may as well fix it in the
> same go: I suppose this setting should be behind the lmp_bredr_capable
> check as LE-only controllers would not support it. That said, we might
> also want to be looking at the controller version.

that is a good point since there is really no point in exposing this for LE only controllers.

Version vise we could be extremely strict and limit it to 2.1 or later, but I am not sure if this matters. The Bluetooth SIG defined Bluetooth 3.0 + HS as minimum 2.1 BR/EDR controller + AMP. With that combination you are allowed to brand it as 3.0 + HS. They never defined anything for 2.0 and earlier controllers, but technically speaking it is possible to do high speed with these as well. The reason why it was not defined is because at that time only two specification were allowed to be active for qualification. So nobody bothered to look back past 2.1.

>> 	if (lmp_le_capable(hdev)) {
>> 		settings |= MGMT_SETTING_LE;
>> @@ -1344,10 +1341,6 @@ static int set_hs(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
>> 
>> 	BT_DBG("request for %s", hdev->name);
>> 
>> -	if (!enable_hs)
>> -		return cmd_status(sk, hdev->id, MGMT_OP_SET_HS,
>> -				  MGMT_STATUS_NOT_SUPPORTED);
>> -
>> 	if (cp->val != 0x00 && cp->val != 0x01)
>> 		return cmd_status(sk, hdev->id, MGMT_OP_SET_HS,
>> 				  MGMT_STATUS_INVALID_PARAMS);
> 
> It seems like the command handler is also missing a check for
> lmp_bredr_capable and a NOT_SUPPORTED return in that case. This should
> probably be part of a separate patch though.

I think that I do that in the same patch. I completely overlooked the fact that we should have limited this to BR/EDR capable controllers.

> Some mgmt-tester cases for all this would be nice too :)

Yes of course, once I get to it. If anybody wants to beat me to it, I am fine with that as well.

Regards

Marcel

