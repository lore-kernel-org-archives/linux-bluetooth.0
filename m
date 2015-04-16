Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH v7] Bluetooth: btusb: Add Realtek 8723A/8723B/8761A/8821A support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAD8Lp468eiB4j-gTxQrXRHBO_QGsn3_yctyUrE5PFCJA+Xtj4g@mail.gmail.com>
Date: Thu, 16 Apr 2015 09:59:50 -0700
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	Larry Finger <larry.finger@lwfinger.net>,
	Champion Chen <champion_chen@realsil.com.cn>,
	Carlo Caione <carlo@endlessm.com>
Message-Id: <5B35A3F5-7217-4079-B151-EB1D834EBA47@holtmann.org>
References: <1429130874-24831-1-git-send-email-drake@endlessm.com> <3B9B5B7C-9801-4A1D-8585-59DBD156148C@holtmann.org> <CAD8Lp468eiB4j-gTxQrXRHBO_QGsn3_yctyUrE5PFCJA+Xtj4g@mail.gmail.com>
To: Daniel Drake <drake@endlessm.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

>> Since this is not your fault, I am willing to merge this change (after minor cleanup) and then convert it over to move the vendor HCI commands into btrtl.ko separate module.
>> 
>> I have already done this for btbcm.ko and btintel.ko and I will do this with other vendor details as well. So this is the strategy that we are heading towards. As I said, this is something that came along and is a new requirement and I am willing to do fix this up for you after merging the patch. So nothing to worry about. It is just a heads up.
> 
> Nice. I would be happy to do this, but it might take me a week or so
> to get to it.

no worries. Just address my comments and I can deal with moving this into a separate module. I have no issue with doing that into a two step process.

>> This needs to be a separate patch on top of adding basic support for Realtek devices. So please split this out.
>> 
>> And while you do, please create a data->flags for it and not copy the driver_info into the btusb_data structure. Lets define a common flag indicating the need for reset_resume = 1. And then only if the Realtek hardware has been detected, this flag gets set.
> 
> OK. I will submit this as a separate patch once the main part has gone in.

Sounds good to me.

Regards

Marcel

