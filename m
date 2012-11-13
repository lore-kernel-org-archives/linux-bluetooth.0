Return-Path: <cyrus@holtmann.org>
Date: Tue, 13 Nov 2012 10:09:28 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Update dbusoob API
Message-ID: <20121113080928.GB2206@x220>
References: <1352735596-731-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1352735596-731-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Nov 12, 2012, Szymon Janc wrote:
> This updates AddRemoteData method to create and return device object path.
> 
> With recent change on how new device objects are created it is no
> longer possible to create device object from string with
> org.bluez.Adapter interface. When adding OOB data for specified
> address device object is created if it was not yet existing.
> 
> Path to object is returned in AddRemoteData to avoid need for extra
> FindDevice() call on org.bluez.Adapter to get object maching specified
> address.
> 
> Question:
> Should RemoveRemoteData be updated to accept device path instead of address?
> (and therefore require existing object, this method doesn't remove object or
> any storage data but only deletes hash/rand kept in kernel).

I'm not sure about this one. Usually passing object paths as a parameter
means you should be instead having the method on top of the object path
itself. Maybe we just keep this symmetric for now by using the address
instead.

Anyway, I went ahead and applied the AddRemoteData patch (after removing
the Change-Id tag - please remember to remove those in the future).

Johan
