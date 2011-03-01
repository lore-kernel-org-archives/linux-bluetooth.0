Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110301154919.GB27312@kroah.com>
References: <AANLkTi=_gAQiAqKsYa2=Haq0ceJwK3n7OafDk6Lb7MZE@mail.gmail.com>
	<20110301154919.GB27312@kroah.com>
Date: Tue, 1 Mar 2011 23:53:55 +0800
Message-ID: <AANLkTi=wW0jEvOnKR+=iYnyYE4DedQ9AV5HVSwUqdvBT@mail.gmail.com>
Subject: Re: [stable] [2.6.38-rc6, patch] fix hci_dev_list locking...
From: Daniel J Blueman <daniel.blueman@gmail.com>
To: Greg KH <greg@kroah.com>
Cc: linux-bluetooth@vger.kernel.org, stable@kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 1 March 2011 23:49, Greg KH <greg@kroah.com> wrote:
> On Tue, Mar 01, 2011 at 11:41:38PM +0800, Daniel J Blueman wrote:
>> Release acquired lock on error path, fixing potential hang up.
>>
>> Signed-off-by: Daniel J Blueman <daniel.blueman@gmail.com>
>>
>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>> index f827fd9..ace8726 100644
>
> Please go read Documentation/stable_kernel_rules.txt for how to properly
> submit patches to the stable kernel tree (hint, this way was not
> correct...)

Good tip; I'll follow it up.

Thanks,
  Daniel
-- 
Daniel J Blueman
