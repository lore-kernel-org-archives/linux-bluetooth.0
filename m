Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Ankur Patel <ankur@embertec.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: btmgmt: failure with advertising report event
Date: Tue, 28 Apr 2015 11:14:10 +0200
Message-ID: <2192025.GhQfbnVRUg@leonov>
In-Reply-To: <BD5E516FF3711A41B93DC005170007BB010D94331BDC@EMBSVR01.ember.local>
References: <BD5E516FF3711A41B93DC005170007BB010D94331BDC@EMBSVR01.ember.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ankur,

On Tuesday 28 of April 2015 17:24:58 Ankur Patel wrote:
> Hello Friends,
> 
> I am using Linux Kernel 3.10.32 on i.mx28 based platform with TI WL1831
> WiFi/BT Module. It runs linux with Bluez 5.30. I am trying to run tests on
> PTS esp. for LE only mode. Hence following
> http://git.kernel.org/cgit/bluetooth/bluez.git/tree/android/pts-gap.txt
> commands to execute on device with "btmgmt" to run the tests. It fails to
> execute most of the commands mentioned for eg. "btmgmt advertising on"
> 
> It returns with Error:
> root@imx28evk:~# btmgmt advertising on
> Set Advertising for hci0 failed with status 0x01 (Unknown Command)
> 
> Any pointers on how to solve this error?
> 
> I have read some more documentation and found (not sure) that full feature
> for btmgmt is supported with Linux Kernel 3.18 only. Is that true? If Yes,
> Is there any way I can use that with v3.10.32?

You need newer kernel. Or at least newer kernel bluetooth subsystem ie via 
backports project [1].

You can check in mgmt-api.txt [2] what commands were introduced in which 
kernel version.

> Regards,
> Ankur
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


[1] https://backports.wiki.kernel.org
[2] https://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/mgmt-api.txt

-- 
BR
Szymon Janc
