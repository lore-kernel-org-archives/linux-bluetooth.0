Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [BlueZ v5] tools/mgmt_tester: expect 0 rp when removing all adv inst
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1432507209-23081-1-git-send-email-fgrandel@gmail.com>
Date: Mon, 25 May 2015 02:52:21 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <0C49B0C6-E9DA-4A01-A54B-917E63F6C0E5@holtmann.org>
References: <1430408000-17785-1-git-send-email-fgrandel@gmail.com> <1432507209-23081-1-git-send-email-fgrandel@gmail.com>
To: Florian Grandel <fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Florian,

> The kernel would previously return a hard coded instance value of 0x01
> even when removing multiple advertising instances. This was ok as long
> as we only had a single advertising instance but no longer makes sense
> now that we allow for multiple advertising instances.
> 
> We therefore expect the mgmt API to return zero when multiple instances
> have been removed. This corresponds to the semantics of the mgmt API
> call made in the first place.
> 
> The corresponding test is updated to reflect that logic.

this sounds like a bug that exists already today. It should make no difference is you support only once instance or multiple. If you remove all of them (aka clear them), the return value should be 0.

Regards

Marcel

