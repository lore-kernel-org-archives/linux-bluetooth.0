Return-Path: <cyrus@holtmann.org>
From: "Zheng, Wu" <wu.zheng@intel.com>
To: "Holtmann, Marcel" <marcel.holtmann@intel.com>
CC: "'linux-bluetooth@vger.kernel.org'" <linux-bluetooth@vger.kernel.org>
Subject: RE: "SMP security requested but not available" when BT_6lowpan
 connection
Date: Fri, 11 Sep 2015 05:08:44 +0000
Message-ID: <2CF57A644018A745B8FE029C7223E16E11A9C466@SHSMSX104.ccr.corp.intel.com>
References: <2CF57A644018A745B8FE029C7223E16E11A91C41@SHSMSX104.ccr.corp.intel.com>
 <8D7E2DC8-B9FE-45CD-A873-CC20DAE9769C@holtmann.org>
 <2CF57A644018A745B8FE029C7223E16E11A9522C@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

6lowpan over BT LE works well in the bluetooth-next kernel.

The key patch is Johan's 0dd5c7aa199b25a88e9fa72824abaf0020ec8066.

For fixing the related bug in yocto project, I have submitted the patch to linux-yocto upstream.

Thanks.

Best Regards
Zheng Wu

>-----Original Message-----
>From: linux-bluetooth-owner@vger.kernel.org
>[mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Zheng, Wu
>Sent: Wednesday, September 9, 2015 2:46 PM
>To: Marcel Holtmann
>Cc: 'linux-bluetooth@vger.kernel.org'
>Subject: RE: "SMP security requested but not available" when BT_6lowpan 
>connection
>
>Hi Marcel,
>
>I will try it. Thanks.
>
>Best Regards
>Zheng Wu
>
>-----Original Message-----
>From: Marcel Holtmann [mailto:marcel@holtmann.org]
>Sent: Wednesday, September 9, 2015 1:59 PM
>To: Zheng, Wu
>Cc: linux-bluetooth@vger.kernel.org
>Subject: Re: "SMP security requested but not available" when BT_6lowpan 
>connection
>
>Hi Wu,
>
>> When I use kernel 4.1.6 to test BT 6lowpan, the error of "SMP 
>> security
>requested but not available" is shown.
>>
>> 1. I use bluetoothctl power on
>>
>> 2. echo 1 > 6lowpan_enable
>>
>> 3. echo "connect 00:XX:XX:XX:XX:XX:XX 1" > 6lowpan_control.
>>
>> Then "SMP security requested but not available".
>>
>> I test kernel 4.1.3 and BT 6lowpan works well.
>>
>> Any suggestion? Thanks.
>
>can try to boot a bluetooth-next kernel and see if the error is still 
>present. We included a fix for the warning.
>
>Regards
>
>Marcel
>
>--
>To unsubscribe from this list: send the line "unsubscribe 
>linux-bluetooth" in the body of a message to majordomo@vger.kernel.org 
>More majordomo info at http://vger.kernel.org/majordomo-info.html
