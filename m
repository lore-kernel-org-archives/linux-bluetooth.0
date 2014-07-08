Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Add a new PID/VID 0cf3/e005 for AR3012.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <53BB9E5F.9020101@ahsoftware.de>
Date: Tue, 8 Jul 2014 12:35:12 +0200
Cc: Peng Chen <pengchen@qti.qualcomm.com>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Linux Bluetooth mailing list
	<linux-bluetooth@vger.kernel.org>, kumo@qca.qualcomm.com,
	taowang@qti.qualcomm.com
Message-Id: <D0167450-1E5D-49A1-8D49-6D6AC528C463@holtmann.org>
References: <1377853792-17589-1-git-send-email-pengchen@qca.qualcomm.com> <53A40687.80004@ahsoftware.de> <850D59CB-8032-4095-AB96-61920042DC55@holtmann.org> <53BB9E5F.9020101@ahsoftware.de>
To: Alexander Holler <holler@ahsoftware.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alexander,

>>> which is wrong and disables the ath3k driver.
>> 
>> I reverted the broken patch in bluetooth.git now and marked it for 3.15 stable.
> 
> Must got missed, it's not in 3.15.4 nor in 3.15.5.
> 
> As my solution was a revert too, I can offer a Tested-By, if such is needed, at least in regard to the point that ath3k-dongles will work again after reverting ca58e5.

it is in net tree, but not in 3.16-rcX yet. Only after it got into Linus' tree it can be backported to stable tree.

Regards

Marcel

