Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH] Bluetooth: Add support for entering limited discoverable mode
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20131015073157.GA24495@x220.p-661hnu-f1>
Date: Tue, 15 Oct 2013 10:52:11 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <66F13BAB-8341-44B5-9D84-A55DFDD6C324@holtmann.org>
References: <1381792099-8732-1-git-send-email-marcel@holtmann.org> <20131015073157.GA24495@x220.p-661hnu-f1>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>> +	if (cp->val) {
>> +		struct hci_cp_write_current_iac_lap cp;
>> +
>> +		if (timeout > 0) {
>> +			/* Limited discoverable mode */
> 
> Wouldn't we want to follow the recommendation from the Core spec here,
> volume 3, part C, section 4.1.2.1:
> 
> "A Bluetooth device should not be in limited discoverable mode for more than
> TGAP(104)"
> 
> TGAP(104) in turn is defined as 1 minute (vol 3, part C, Appendix A).

I was not going to be this strict. So yes, userspace can violate the GAP part here, but it might be a good idea to ensure that when a too large value is entered we stick with general discoverable mode. However is this really worth it.

Another option is to just reject too large timeout values as invalid parameters and force userspace to implement large timeouts with general discoverable mode in userspace.

Regards

Marcel

