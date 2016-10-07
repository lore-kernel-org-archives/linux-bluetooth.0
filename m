Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHFy41_JW_iUh5=yS8vV2MmeQf7JX=tMzPnQ-3qFf48Ho7K90g@mail.gmail.com>
References: <CADEmUHPqOU4SpUuN2gWHNGFUTZ+fpXszjwJSNu=Wfq1kjtOzSA@mail.gmail.com>
 <CAHFy41_JW_iUh5=yS8vV2MmeQf7JX=tMzPnQ-3qFf48Ho7K90g@mail.gmail.com>
From: Hieu Le <hieu.le@veriksystems.com>
Date: Fri, 7 Oct 2016 14:59:41 +0700
Message-ID: <CADEmUHNPhTMwfLArf1ezVS1cUcTEX6_1kL_JjcE-9i5k86QPfg@mail.gmail.com>
Subject: Re: BlueZ: How to change supervision timeout
To: Joseph Hwang <josephsih@google.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thank you for your valuable input.

Unfortunately, in my case, I hook my own GATT server into BlueZ using
D-Bus API and I am looking for the way to change the supervision
timeout on the fly.

I looked at hcitool source code and found the command "hcitool lst"
command which seems to be usable for changing the supervision timeout
param. However, I got error message while executing it. It seems
really odd because I got no problem when listing the current
connection using "hcitool conn".

~ # hcitool conn
Connections:
        < LE 00:16:B6:29:7F:F0 handle 100 state 1 lm MASTER
~ # hcitool lst 00:16:B6:29:7F:F0
Get connection info failed: No such file or directory

My kernel version is 3.14.43

Any suggestion would be great.

Regards,
Hieu.


On Thu, Oct 6, 2016 at 11:09 PM, Joseph Hwang <josephsih@google.com> wrote:
> I modified the supervision timeout by changing the constant in kernel. I did
> this as an experiment to see if a longer supervision timeout helps improving
> the connection stability. You need to make and update kernel by yourself
> though. There might be a better way...
>
> If you need it, the patch looks like
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>
> index 9e58c0c..17b9bba 100644
>
> --- a/net/bluetooth/hci_core.c
>
> +++ b/net/bluetooth/hci_core.c
>
> @@ -2960,7 +2960,7 @@ struct hci_dev *hci_alloc_dev(void)
>
>         hdev->le_conn_min_interval = 0x0028;
>
>         hdev->le_conn_max_interval = 0x0038;
>
>         hdev->le_conn_latency = 0x0000;
>
> -       hdev->le_supv_timeout = 0x002a;
>
> +       hdev->le_supv_timeout = 0x00c8;
>
>         hdev->le_def_tx_len = 0x001b;
>
>         hdev->le_def_tx_time = 0x0148;
>
>         hdev->le_max_tx_len = 0x001b;
>
>
> Joseph
>
>
> On Wed, Oct 5, 2016 at 11:37 PM, Hieu Le <hieu.le@veriksystems.com> wrote:
>>
>> Hello,
>>
>> I am using BlueZ-5.39 to develop my application which creates a GATT
>> server and uses BlueZ D-Bus method call "RegisterProfile" to hook
>> itself to Bluetooth daemon.
>>
>> The application is working fine. However, I want to change the default
>> supervision timeout because Central and Peripheral sometimes got
>> disconnected when moving away.
>>
>> I searched all the document. Unfortunately, I cannot find any D-Bus
>> API to accomplish it.
>>
>> Could you please suggest me any solution for this?
>>
>> Many thanks for your valuable input.
>> Hieu
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
>
> --
>
> Joseph Shyh-In Hwang
> Email: josephsih@google.com
>



-- 
---- Hieu Le ---
