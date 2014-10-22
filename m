Return-Path: <cyrus@holtmann.org>
Message-ID: <61125.86.105.94.79.1413985352.squirrel@boosthardware.com>
In-Reply-To: <7FC77530-F48C-436C-8954-195E9CD08E97@holtmann.org>
References: <59774.86.105.94.79.1413974113.squirrel@boosthardware.com>
    <7FC77530-F48C-436C-8954-195E9CD08E97@holtmann.org>
Date: Thu, 23 Oct 2014 00:42:32 +1100 (EST)
Subject: Re: rtk_btusb issues
From: "Patrick Shirkey" <pshirkey@boosthardware.com>
To: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On Thu, October 23, 2014 12:05 am, Marcel Holtmann wrote:
> Hi Patrick,
>
>> I have an android device running the rtk_btusb driver. The original
>> driver
>> was a couple of years old and there was a problem with stability with
>> BLE.
>> In addition the localname was not found in the scan_response data.
>>
>> I upgraded the bluetooth stack by manually backporting from a recent
>> kernel. That fixed the issue wit the scan_repsonse data but there were
>> still stability issues with BLE devices (although slightly improved
>> compared to the older bluetooth stack).
>>
>> I have tried upgrading the driver to the latest version of the rtk_btusb
>> driver from the git repo and ported the hooks for bluedroid from the old
>> driver however I get issues with hci send command when loading the
>> driver.
>>
>> http://pastebin.com/hXALmXBr
>>
>> I traced the command but I am not sure where the send value is
>> generated.
>> I can see the function definition in the hci_dev struct but not the
>> location where the value is actually set.
>>
>> I thought it might be an issue specific to bluedroid so I installed
>> bluez
>> but the issue is still there so it appears to be a bug in my version of
>> the driver or something wrong with the bluetooth kernel layer.
>>
>> I went back to the older version of the driver running against  bluez
>> instead of bluedroid. That gets me further along but I still cannot
>> initialise the bluetooth system on the device.
>>
>> http://pastebin.com/HcSZXiMu
>>
>> Does anyone have any suggestions for how to go about resolving this
>> situation I have got myself into?
>
> the rtk_btusb driver is not an upstream driver and that is the main
> problem. There has been recently an effort to get btusb support the
> Realtek devices, but then it went silent again.
>
> What you need is having proper Realtek support in btusb and nothing else.
> Out of tree hacked up vendor drivers are not something any of us will
> likely have a look at and trying to fix.
>

My quest is to fix the stability issue not the rtk_btusb driver.  I
spotted the "new" branch in the git tree. I am testing that driver now.

Do you know if there are known issues with BLE stability on the 8723au
chipset?




--
Patrick Shirkey
Boost Hardware Ltd
