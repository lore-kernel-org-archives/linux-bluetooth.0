Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <AM5PR0502MB3059AD084567C3660CF64B2DEAB90@AM5PR0502MB3059.eurprd05.prod.outlook.com>
References: <AM5PR0502MB3059AD084567C3660CF64B2DEAB90@AM5PR0502MB3059.eurprd05.prod.outlook.com>
From: Joseph Hwang <josephsih@google.com>
Date: Mon, 9 Apr 2018 10:51:14 +0800
Message-ID: <CAHFy41-bOLwUxk+bhWOqLLhj2xnpyN-4ymnHneY=3obOFUn-1A@mail.gmail.com>
Subject: Re: Bluetooth connection drops after idle time
To: Dr Nukular <dr.nukular@outlook.at>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dr Nukular:

  As far as I know, it is the peripheral device that enters power
saving mode and disconnects.

On Sat, Apr 7, 2018 at 2:32 PM, Dr Nukular <dr.nukular@outlook.at> wrote:
>
> Bluetooth connection drops if the device, such as mouse or keyboard, is i=
nactive for some time. Once the device is used again the bluetooth connecti=
on comes back on. This would not be an issue, if it wasn't for the time tha=
t it takes until the connection is re-established again. It is not responsi=
ve enough and interferes with the workflow, if you have to wait several sec=
onds until you can use your device again, especially since you naturally ex=
pect an immediate response.
>
> If this is not a bug, then please enable a setting to disable that "featu=
re" or improve the time by reducing it to a minimum to reconnect the device=
.--
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20

Joseph Shyh-In Hwang
Email: josephsih@google.com
