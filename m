Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH] Bluetooth: Fix missing hci_dev_lock/unlock
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20141210123752.GA30555@t440s.lan>
Date: Wed, 10 Dec 2014 13:41:38 +0100
Cc: JAGANATH KANAKKASSERY <jaganath.k@samsung.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <77B96975-22E2-403D-BE3B-A3D12D3E77E4@holtmann.org>
References: <935145568.61511418213470087.JavaMail.weblogic@epmlwas05a> <20141210123752.GA30555@t440s.lan>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>>>> 	err = hci_dev_do_open(hdev);
>>>> 	if (err < 0) {
>>>> +		hci_dev_lock(hdev);
>>>> 		mgmt_set_powered_failed(hdev, err);
>>>> +		hci_dev_unlock(hdev);
>>>> 		return;
>>>> 	}
>> 
>>> I wonder is some of the mgmt_ function should just take the hci_dev
>>> lock. Are there cases where we don't want them to take the look?
>> 
>> There are many mgmt_functions called from hci_event.c which don't
>> require lock.  You prefer moving the lock inside
>> mgmt_set_powered_failed()?
> 
> This should be kept consistent imo. Either all mgmt_* functions called
> from hci_core/event.c should be responsible for taking the lock
> themselves or none should be. I think right now the general rule is that
> hci_core/event.c take the lock first, and this is mainly because a lot
> of code that needed calling into mgmt.c was already holding the lock.
> I.e. moving the taking into mgmt.c would for many places have required
> awkward looking hdev_unlock(); mgmt_foo(); hdev_lock(); constructions.

we could also rename some to __mgmt_foo which means they are not taking the lock and others to mgmt_bar which take the lock by themselves. And then see if they actually have variations where we would need both.

Regards

Marcel

