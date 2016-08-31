Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Two second pending connection timeout prevents connection to devices with long advertising interval
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <B0B1991C-FD3E-4E08-9641-DE745A6EC690@metanate.com>
Date: Wed, 31 Aug 2016 05:58:21 -0700
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@intel.com>
Message-Id: <9942937A-4799-4AA2-9551-8FEBF110550B@holtmann.org>
References: <B0B1991C-FD3E-4E08-9641-DE745A6EC690@metanate.com>
To: Northfield Stuart <stu@metanate.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stu,

> We are currently working with a BLE device which (for power consumption reasons) uses an unusually large advertisement period of ten seconds (unusual, but allowed within the BLE specification). We don’t have the option of reducing the advertising interval for this product.
> 
> This works with older kernels (e.g. 4.2.6 in RH F23), but on later kernels it appears that the kernel times out the connection attempt after only two seconds.
> 
> I believe I have tracked down the change responsible to a patch from Johan Hedberg <johan.hedberg@intel.com> on 2014-07-06, which appears to split the BLE connection timeout in to two variants, HCI_LE_CONN_TIMEOUT which remains at 20 seconds, and the newly added one, HCI_LE_AUTOCONN_TIMEOUT, which has been reduced down to two seconds. 
> 
> I understand, from other threads touching on this subject (see links below - I am at least not the only person to have hit this problem) that this 2s timeout is chosen to avoid blocking other connections, and agree that the average user probably doesn’t need to be able to handle such slow devices. However, is there any reason why this timeout is hardcoded in the source rather than a tuneable parameter, which would at least allow those of us who do need to interact with such devices to be able to configure the linux bluetooth stack suitably.
> 
> Personally, I would regard a change which prevents interoperability with a conformant device as a regression, but I can see why it was done, and why it isn’t an issue for the vast majority of users and devices.

the problem is that in order to send a CONNNECT_REQ, the HCI_LE_Create_Connection command needs to see connectable advertising packet one more time. So the longer time you give to HCI_LE_Create_Connection to find it, the longer everything else in the system is blocked. Since only one HCI_LE_Create_Connection can be running at the same time.

Now if the peripheral in question would actually include ​«Advertising Interval» AD type in its advertising, then we could automatically adjust the scan window/interval and timeout when connection to such a device. Can you run a btmon trace and show the advertising data you are getting.

Regards

Marcel

