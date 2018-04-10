Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <AM5PR0502MB305911BEBD5C2227E4C33AEFEABF0@AM5PR0502MB3059.eurprd05.prod.outlook.com>
References: <AM5PR0502MB3059AD084567C3660CF64B2DEAB90@AM5PR0502MB3059.eurprd05.prod.outlook.com>
 <CAHFy41-bOLwUxk+bhWOqLLhj2xnpyN-4ymnHneY=3obOFUn-1A@mail.gmail.com> <AM5PR0502MB305911BEBD5C2227E4C33AEFEABF0@AM5PR0502MB3059.eurprd05.prod.outlook.com>
From: Joseph Hwang <josephsih@google.com>
Date: Tue, 10 Apr 2018 16:53:36 +0800
Message-ID: <CAHFy418YKPZnEoBh=rmh7EQVtLVHRuodmNPS2KMQ0fBBdbyf-Q@mail.gmail.com>
Subject: Re: Bluetooth connection drops after idle time
To: Dr Nukular <dr.nukular@outlook.at>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dr Nukular:

  You could run "btmon -w btsnoop.log" to capture the HCI logs, have
your devices connected, let them idle for a while, and observe which
side terminates the connection.

  Also please make sure if you use the same peripheral devices when
you compare the re-connection latency before and after you upgrade
kernel/system. Bluetooth classic mouse/keyboard work differently from
BLE mouse/keyboard. When a classic bluetooth device disconnects, its
input node will be removed from kernel. Next time when reconnecting,
it needs to create its node again in kernel. On the other hand, when a
BLE device disconnects, its input node remains. Hence, a BLE device is
supposed to be a bit faster to reconnect.

Joseph


On Tue, Apr 10, 2018 at 2:06 AM, Dr Nukular <dr.nukular@outlook.at> wrote:
> Hi Joseph,
>
>
> Thanks for the reply. Not sure, but that might be the case, however this
> issue started after a kernel / system update. Does that mean that before the
> update the system was ignoring the power saving mode of that device? In that
> case what changed exactly?
>
>
> Fedora 27. kernel 4.15.14. gnome-shell 3.26.2 gnome-bluetooth 3.26.1.
>
> ________________________________
> Von: Joseph Hwang <josephsih@google.com>
> Gesendet: Montag, 9. April 2018 04:51:14
> An: Dr Nukular
> Cc: linux-bluetooth@vger.kernel.org
> Betreff: Re: Bluetooth connection drops after idle time
>
> Hi Dr Nukular:
>
>   As far as I know, it is the peripheral device that enters power
> saving mode and disconnects.
>
> On Sat, Apr 7, 2018 at 2:32 PM, Dr Nukular <dr.nukular@outlook.at> wrote:
>>
>> Bluetooth connection drops if the device, such as mouse or keyboard, is
>> inactive for some time. Once the device is used again the bluetooth
>> connection comes back on. This would not be an issue, if it wasn't for the
>> time that it takes until the connection is re-established again. It is not
>> responsive enough and interferes with the workflow, if you have to wait
>> several seconds until you can use your device again, especially since you
>> naturally expect an immediate response.
>>
>> If this is not a bug, then please enable a setting to disable that
>> "feature" or improve the time by reducing it to a minimum to reconnect the
>> device.--
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
>
> Joseph Shyh-In Hwang
> Email: josephsih@google.com



-- 

Joseph Shyh-In Hwang
Email: josephsih@google.com
