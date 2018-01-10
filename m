Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH v3 00/13] Bluetooth on 2015+ MacBook (Pro)
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1515418113.7000.791.camel@linux.intel.com>
Date: Wed, 10 Jan 2018 15:03:42 +0100
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Frederic Danis <frederic.danis.oss@gmail.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Max Shavrick <mxms@me.com>, Leif Liddy <leif.liddy@gmail.com>,
        Daniel Roschka <danielroschka@phoenitydawn.de>,
        Ronald Tschalaer <ronald@innovation.ch>,
        "Peter Y. Chuang" <peteryuchuang@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Sue White <sue.white@lairdtech.com>,
        Ilya Faenson <ifaenson@broadcom.com>
Message-Id: <892C25BB-FD53-4AEF-98E3-7DE45B40F05A@holtmann.org>
References: <cover.1515348092.git.lukas@wunner.de>
 <1515418113.7000.791.camel@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukas,

>> Enable UART-attached Bluetooth on 2015+ Macs, v3.
>> 
>> The series has grown to 13 patches because bugs in the driver keep
>> cropping up.
>> 
>> Changes since v2:
>> 
>> - In patch [01/13] ("Mandate presence of shutdown and device wake
>> GPIO"):
>>  Keep netdev indentation style. (Marcel)
>> 
>> - New patch [04/13] to fix an IRQ race on ->close.
>> 
>> - New patch [05/13] to fix an unbalanced pm_runtime_disable(). (Andy)
>> 
>> - New patch [06/13] to invalidate the IRQ if requesting it failed.
>> 
>> - New patch [08/13] to add callbacks to toggle GPIOs.
>>  This makes the subsequent addition of Mac support less intrusive.
>>  Replaces patch "Add helper to toggle device wake GPIO" in v2. (Andy)
>> 
>> - In patch [09/13] ("Handle errors properly"):
>>  Drop redundant assignment. (Andy)
>> 
>> - In patch [10/13] ("Support Apple GPIO handling"):
>>  Don't enable runtime PM on Macs for lack of usable host wake IRQ
>> (Hans),
>>  s/BlueTooth/Bluetooth/ in kerneldoc. (Marcel)
>> 
>> - Move patch "Silence IRQ printk" to end of series as it's merely
>>  a cleanup and no longer necessary for Mac support.
>> 
>> - New patch [12/13] to use msleep() instead of mdelay()
>>  after toggling device wake pin. (Andy)
>> 
>> - New patch [13/13] to fix sleep mode struct ordering.
>> 
>> - Drop incorrect patch "Enable runtime PM despite absence of IRQ".
>> (Hans)
>> 
> 
> I didn't test this myself (yet), the code looks more or less fine to me,
> FWIW, 
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

can we get a v4 with the known fixes?

Regards

Marcel

