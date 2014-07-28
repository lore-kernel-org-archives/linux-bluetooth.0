Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [RFC v1 1/1] doc/gatt-api: New API properties and methods for the GATT D-Bus API.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHrH25To=NvJC+4E6U-2S5pMc1qORvKOpbG2atY9=CFn4Zwcew@mail.gmail.com>
Date: Mon, 28 Jul 2014 16:51:21 -0700
Cc: "Gu, Chao Jie" <chao.jie.gu@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <B5CC27DE-EB1B-47B7-A1E2-F264CC09924B@holtmann.org>
References: <1405986034-29122-1-git-send-email-armansito@chromium.org> <1405986034-29122-2-git-send-email-armansito@chromium.org> <3D02B219753AD44CBDDDE484323B1774112D2C2C@SHSMSX104.ccr.corp.intel.com> <CAHrH25QAR=y6Dtn4Y-t=EX1h6Oxn9ir7rWft2m+mVsBHfab1Wg@mail.gmail.com> <409335B4-82B3-40D2-970A-D39416F02591@holtmann.org> <CAHrH25To=NvJC+4E6U-2S5pMc1qORvKOpbG2atY9=CFn4Zwcew@mail.gmail.com>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

>> I think this depends a little bit. Most values will be return the exact same value that you write into it. That is what they are suppose to do anyway. The only exception here are control endpoints. So I would agree that for control endpoints we do not expose the Value property at all.
>> 
> 
> Yes, we shouldn't expose the Value property if the characteristic
> properties field doesn't contain "read", "notify", or "indicate". With
> respect to caching the value before a write operation, I'm still
> hesitant towards making any assumptions about the value. I wouldn't
> want to cache the value until after the write operation has completed
> successfully (which is only possible to determine with the "write
> request" and "reliable long write" procedure) and there may be some
> race conditions where a characteristic might immediately change it's
> value and send a notification before we had a chance to store the
> write value. In this case the latest cached value would be incorrect.
> I understand that this is an edge case but it's enough to raise some
> concern.

without thinking too much about the details, I think when notification is enabled, then we just wait for the update from the remote device. If notification is not enabled, then we update the value on write. Since everything is central in bluetoothd, we should be able to make smart decisions.

Regards

Marcel

