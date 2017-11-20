Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7B53A3173656CB4190908401FE75F4F8600A3C34@exgmbxfz01.sasken.com>
References: <7B53A3173656CB4190908401FE75F4F8600A3C34@exgmbxfz01.sasken.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 20 Nov 2017 17:27:04 +0200
Message-ID: <CABBYNZLLBq=ZDFhggp_gN7uXZQArHsBUAJgQJVb8uiJ8UxXNcw@mail.gmail.com>
Subject: Re: Facing issue with Bluez read API
To: Anitha Chandrasekar <anitha.chandrasekar@sasken.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anitha,

On Mon, Nov 20, 2017 at 1:55 PM, Anitha Chandrasekar
<anitha.chandrasekar@sasken.com> wrote:
> Hi All,
>
> We are using bluez stack to work as a GATT central device on a 32 bit pro=
cessor. We are trying to call Bluez 5.46 read api. We see that at stack the=
 callback method_call_reply(gdbus/client.c) is not being called, due to whi=
ch it is unable to call our registered callback.
>
> Few observations:
> 1) This happens only when read is called, and the peripheral device is in=
 sleep.
> 2) We have verified through dbus-monitor --system and the dbus has sent t=
he message as NOT CONNECTED, but this is not reached to gdbus client.
> 3) It perfectly works fine on a 64th bit processor , but not working on 3=
2bit processor.
>
> The dbus version used is 1.10.10. The bluez stack used is bluez5.46.Using=
 x86, 32 bit processor.

If you could please send some logs of bluetoothd and btmon when this
is happening.

>
> Any information will be of great help. Thanks!!
>
> Regards,
> Anitha
>
> ________________________________
>
> SASKEN BUSINESS DISCLAIMER: This message may contain confidential, propri=
etary or legally privileged information. In case you are not the original i=
ntended Recipient of the message, you must not, directly or indirectly, use=
, disclose, distribute, print, or copy any part of this message and you are=
 requested to delete it and inform the sender. Any views expressed in this =
message are those of the individual sender unless otherwise stated. Nothing=
 contained in this message shall be construed as an offer or acceptance of =
any offer by Sasken Technologies Limited ( formerly known as "Sasken Commun=
ication Technologies Limited" ) unless sent with that express intent and wi=
th due authority of Sasken. Sasken has taken enough precautions to prevent =
the spread of viruses. However the company accepts no liability for any dam=
age caused by any virus transmitted by this email.
> Read Disclaimer at http://www.sasken.com/mail-disclaimer/
>
> ________________________________
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Luiz Augusto von Dentz
