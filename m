Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [RFC v1 1/1] doc/gatt-api: New API properties and methods for the GATT D-Bus API.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHrH25RkJ8x0SEx5g89496i=iWazorTpvXg7jySdUfBqMht1Pg@mail.gmail.com>
Date: Wed, 30 Jul 2014 09:46:07 -0700
Cc: "Gu, Chao Jie" <chao.jie.gu@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <CB57FC0A-030C-498D-A3E3-988BEF192ACB@holtmann.org>
References: <1405986034-29122-1-git-send-email-armansito@chromium.org> <1405986034-29122-2-git-send-email-armansito@chromium.org> <3D02B219753AD44CBDDDE484323B1774112D2C2C@SHSMSX104.ccr.corp.intel.com> <CAHrH25QAR=y6Dtn4Y-t=EX1h6Oxn9ir7rWft2m+mVsBHfab1Wg@mail.gmail.com> <409335B4-82B3-40D2-970A-D39416F02591@holtmann.org> <CAHrH25To=NvJC+4E6U-2S5pMc1qORvKOpbG2atY9=CFn4Zwcew@mail.gmail.com> <3D02B219753AD44CBDDDE484323B1774112D2F48@SHSMSX104.ccr.corp.intel.com> <CAHrH25RkJ8x0SEx5g89496i=iWazorTpvXg7jySdUfBqMht1Pg@mail.gmail.com>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

>> If we encounter one condition that the value is determine with the "Write Command" procedure which no response for client, should we expose this kind of property ? If we expose it, we have to write command to the remote and read value back immediately, then emit propertychanged signal if read value equals to write value(different from old one).
>> 
> 
> I don't think we should expose this value until we have done an
> initial read (either internally before we construct the D-Bus
> hierarchy or after a call to ReadValue) or via notification. I think
> we should just keep the property hidden until we know what the value
> is, even in the case of a write.

that is the beauty of properties with D-Bus Object Manager, we can actually also invalidate a property and tell the applications that it went away. So yes, initially the value should not be present. If we never read it, then there is no cached value. If we are connecting to a know device, then we only provide the value once we verified that the services have not changed.

>> In your proposal , I think we also should read initial value from remote at the beginning of DBus Hierachy setup. Whatever "read", "notify", or "indicate" even write request to remote, only different value compared with exist cache value such as initial value, then bluez emit propertychanged signal. This would be good, right?
>> 
> 
> I'm not opposed to this, though we can only read the initial value if
> the characteristic supports reads. If the characteristic only supports
> notify or indicate, then we should wait until we receive the first
> notification/indication to expose the property and we keep it hidden
> until then.

Exactly. And with that it is nice for the application since it still does not have to learn any new tricks to get the value. It just sits there and waits until it shows up.

Regards

Marcel

