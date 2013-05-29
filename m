Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH] Bluetooth: Fix mgmt handling of power on failures
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20130528152337.GA3697@joana>
Date: Wed, 29 May 2013 09:58:34 +0900
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <BB0C792C-39F4-4713-B017-AA66CEF209DE@holtmann.org>
References: <1369724867-31011-1-git-send-email-johan.hedberg@gmail.com> <20130528152337.GA3697@joana>
To: Gustavo Padovan <gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

>> If hci_dev_open fails we need to ensure that the corresponding
>> mgmt_set_powered command gets an appropriate response. This patch fixes
>> the missing response by adding a new mgmt_set_powered_failed function
>> that's used to indicate a power on failure to mgmt.
>> 
>> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
>> ---
>> include/net/bluetooth/hci_core.h |    1 +
>> net/bluetooth/hci_core.c         |    6 +++++-
>> net/bluetooth/mgmt.c             |   16 ++++++++++++++++
>> 3 files changed, 22 insertions(+), 1 deletion(-)
> 
> Patch has been applied to bluetooth.git. Thanks.

I rather have this fixed properly with a new error for specifically ERFKILL. Having one stable kernel return rejected and another rfkill is a bad idea.

Regards

Marcel

