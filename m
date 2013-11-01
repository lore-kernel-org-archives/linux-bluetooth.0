Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Subject: Re: [PATCH 1/3] Bluetooth: btmrvl: use cal-data from device-tree instead of conf file
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <477F20668A386D41ADCC57781B1F70430F45757D87@SC-VEXCH1.marvell.com>
Date: Fri, 1 Nov 2013 23:21:37 +0100
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Mike Frysinger <vapier@chromium.org>,
	Amitkumar Karwar <akarwar@marvell.com>
Message-Id: <7202F1D8-1D09-45A7-ACDE-E5870CCC5C4A@holtmann.org>
References: <1383257311-1430-1-git-send-email-bzhao@marvell.com> <39C7BB16-B89A-465E-BB9D-09374FA877C6@holtmann.org> <477F20668A386D41ADCC57781B1F70430F45757D87@SC-VEXCH1.marvell.com>
To: Bing Zhao <bzhao@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bing,

>>> +#include <linux/of.h>
>>> #include <net/bluetooth/bluetooth.h>
>>> #include <net/bluetooth/hci_core.h>
>> 
>> here now it becomes tricky. Does this now depend on CONFIG_OF as well?
> 
> No. It doesn't depend on CONFIG_OF.
> The of.h takes good care of the two OF functions (of_find_node_by_name and of_property_read_u8_array) used in this patch. If CONFIG_OF is not defined, the 1st function returns NULL and the 2nd function returns -ENOSYS.
> 
>> 
>> What happens to x86 systems that generally do not use open firmware or device tree. Do they still
>> work? 
> 
> On x86 systems without OF or device tree, the entire calibration data downloading will be skipped.
> 
>> Which kind of devices need the calibration data anyway? All of them? Just the ones without
>> EEPROM?
> 
> Some ARM versions of Chromebook need the calibration data.
> They do have EEPROM but still need a piece of new calibration data in test mode.
> 
>> 
>> You need to pretty much verbose in your commit message on what is going on. And I get the feeling
>> that you have to handle the case where CONFIG_OF is not selected.
> 
> When CONFIG_OF is not selected, or the specific property is not present in the device tree, the calibration downloading will not happen.
> 
> I can add above messages to the commit log in v2.

that would be a good idea. Thanks.

Regards

Marcel

