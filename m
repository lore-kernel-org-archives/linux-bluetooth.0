Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Anitha Chandrasekar <anitha.chandrasekar@sasken.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: Facing issue with Bluez read API
Date: Tue, 28 Nov 2017 06:19:27 +0000
Message-ID: <7B53A3173656CB4190908401FE75F4F8600AB3DF@exgmbxfz01.sasken.com>
References: <7B53A3173656CB4190908401FE75F4F8600A3C34@exgmbxfz01.sasken.com>,<CABBYNZLLBq=ZDFhggp_gN7uXZQArHsBUAJgQJVb8uiJ8UxXNcw@mail.gmail.com>,<7B53A3173656CB4190908401FE75F4F8600A8D29@exgmbxfz01.sasken.com>,<7B53A3173656CB4190908401FE75F4F8600A8D47@exgmbxfz01.sasken.com>
In-Reply-To: <7B53A3173656CB4190908401FE75F4F8600A8D47@exgmbxfz01.sasken.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

After experimenting for quite sometime, found that adding the 10ms delay in mainloop.c (gdbus/mainloop.c),callback method_call_reply(gdbus/client.c) is called all the time and it worked fine for us.

usleep(10000);
/* Dispatch messages */
	while (dbus_connection_dispatch(conn) == DBUS_DISPATCH_DATA_REMAINS);
usleep(10000);

Any idea without modifying the bluez code, how we can achieve the same?

Regards,
Anitha
________________________________________
From: Anitha Chandrasekar
Sent: Tuesday, November 21, 2017 2:32 PM
To: linux-bluetooth@vger.kernel.org
Subject: RE: Facing issue with Bluez read API

Apologize, re-sending the correct btmon log.

Regards,
Anitha
________________________________________
From: linux-bluetooth-owner@vger.kernel.org [linux-bluetooth-owner@vger.kernel.org] on behalf of Anitha Chandrasekar [anitha.chandrasekar@sasken.com]
Sent: Tuesday, November 21, 2017 1:22 PM
To: linux-bluetooth@vger.kernel.org
Subject: {Possibly Forged} RE: Facing issue with Bluez read API

Hi Luiz,

Thanks for the reply.Attached logs of bluetoothd, dbus and gdb logs(when breakpoints applied during failure case)
This happens not only for read but also during disconnect/write when peripheral device is in sleep.
One more point is, when I put the breakpoint in gdbus/mainloop.c then the flow is perfectly fine.
But if I remove mainloop breakpoint and put it under /usr/src/debug/bluez5/5.46-r0/bluez-5.46/gdbus/client.c:831 (method_call_reply) alone ,then the breakpoint is not hit{We did not receive this callback}.

Basically I am seeing the message is not dispatched via dbus to the gdbus/client.c.

Any inputs would be helpful.

Regards,
Anitha
________________________________________
From: Luiz Augusto von Dentz [luiz.dentz@gmail.com]
Sent: Monday, November 20, 2017 8:57 PM
To: Anitha Chandrasekar
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Facing issue with Bluez read API

Hi Anitha,

On Mon, Nov 20, 2017 at 1:55 PM, Anitha Chandrasekar
<anitha.chandrasekar@sasken.com> wrote:
> Hi All,
>
> We are using bluez stack to work as a GATT central device on a 32 bit processor. We are trying to call Bluez 5.46 read api. We see that at stack the callback method_call_reply(gdbus/client.c) is not being called, due to which it is unable to call our registered callback.
>
> Few observations:
> 1) This happens only when read is called, and the peripheral device is in sleep.
> 2) We have verified through dbus-monitor --system and the dbus has sent the message as NOT CONNECTED, but this is not reached to gdbus client.
> 3) It perfectly works fine on a 64th bit processor , but not working on 32bit processor.
>
> The dbus version used is 1.10.10. The bluez stack used is bluez5.46.Using x86, 32 bit processor.

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
> SASKEN BUSINESS DISCLAIMER: This message may contain confidential, proprietary or legally privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Technologies Limited ( formerly known as "Sasken Communication Technologies Limited" ) unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any virus transmitted by this email.
> Read Disclaimer at http://www.sasken.com/mail-disclaimer/
>
> ________________________________
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--
Luiz Augusto von Dentz
