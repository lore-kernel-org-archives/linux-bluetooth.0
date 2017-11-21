Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Anitha Chandrasekar <anitha.chandrasekar@sasken.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: Facing issue with Bluez read API
Date: Tue, 21 Nov 2017 07:52:33 +0000
Message-ID: <7B53A3173656CB4190908401FE75F4F8600A8D29@exgmbxfz01.sasken.com>
References: <7B53A3173656CB4190908401FE75F4F8600A3C34@exgmbxfz01.sasken.com>,<CABBYNZLLBq=ZDFhggp_gN7uXZQArHsBUAJgQJVb8uiJ8UxXNcw@mail.gmail.com>
In-Reply-To: <CABBYNZLLBq=ZDFhggp_gN7uXZQArHsBUAJgQJVb8uiJ8UxXNcw@mail.gmail.com>
Content-Type: multipart/mixed;
        boundary="_002_7B53A3173656CB4190908401FE75F4F8600A8D29exgmbxfz01saske_"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--_002_7B53A3173656CB4190908401FE75F4F8600A8D29exgmbxfz01saske_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,=0A=
=0A=
Thanks for the reply.Attached logs of bluetoothd, dbus and gdb logs(when br=
eakpoints applied during failure case)=0A=
This happens not only for read but also during disconnect/write when periph=
eral device is in sleep.=0A=
One more point is, when I put the breakpoint in gdbus/mainloop.c then the f=
low is perfectly fine.=0A=
But if I remove mainloop breakpoint and put it under /usr/src/debug/bluez5/=
5.46-r0/bluez-5.46/gdbus/client.c:831 (method_call_reply) alone ,then the b=
reakpoint is not hit{We did not receive this callback}.=0A=
=0A=
Basically I am seeing the message is not dispatched via dbus to the gdbus/c=
lient.c.=0A=
=0A=
Any inputs would be helpful.=0A=
=0A=
Regards,=0A=
Anitha=0A=
________________________________________=0A=
From: Luiz Augusto von Dentz [luiz.dentz@gmail.com]=0A=
Sent: Monday, November 20, 2017 8:57 PM=0A=
To: Anitha Chandrasekar=0A=
Cc: linux-bluetooth@vger.kernel.org=0A=
Subject: Re: Facing issue with Bluez read API=0A=
=0A=
Hi Anitha,=0A=
=0A=
On Mon, Nov 20, 2017 at 1:55 PM, Anitha Chandrasekar=0A=
<anitha.chandrasekar@sasken.com> wrote:=0A=
> Hi All, =0A=
>=0A=
> We are using bluez stack to work as a GATT central device on a 32 bit pro=
cessor. We are trying to call Bluez 5.46 read api. We see that at stack the=
 callback method_call_reply(gdbus/client.c) is not being called, due to whi=
ch it is unable to call our registered callback.=0A=
>=0A=
> Few observations:=0A=
> 1) This happens only when read is called, and the peripheral device is in=
 sleep.=0A=
> 2) We have verified through dbus-monitor --system and the dbus has sent t=
he message as NOT CONNECTED, but this is not reached to gdbus client.=0A=
> 3) It perfectly works fine on a 64th bit processor , but not working on 3=
2bit processor.=0A=
>=0A=
> The dbus version used is 1.10.10. The bluez stack used is bluez5.46.Using=
 x86, 32 bit processor.=0A=
=0A=
If you could please send some logs of bluetoothd and btmon when this=0A=
is happening.=0A=
=0A=
>=0A=
> Any information will be of great help. Thanks!!=0A=
>=0A=
> Regards,=0A=
> Anitha=0A=
>=0A=
> ________________________________=0A=
>=0A=
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
age caused by any virus transmitted by this email.=0A=
> Read Disclaimer at http://www.sasken.com/mail-disclaimer/=0A=
>=0A=
> ________________________________=0A=
> --=0A=
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in=0A=
> the body of a message to majordomo@vger.kernel.org=0A=
> More majordomo info at  http://vger.kernel.org/majordomo-info.html=0A=
=0A=
=0A=
=0A=
--=0A=
Luiz Augusto von Dentz=0A=

--_002_7B53A3173656CB4190908401FE75F4F8600A8D29exgmbxfz01saske_
Content-Type: application/zip; name="logs.zip"
Content-Description: logs.zip
Content-Disposition: attachment; filename="logs.zip"; size=6864;
	creation-date="Tue, 21 Nov 2017 07:47:42 GMT";
	modification-date="Tue, 21 Nov 2017 07:47:42 GMT"
Content-Transfer-Encoding: base64

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
A10DXQNdA10DXQNdA10DXQNdA10DXQNdA10DXQNdA10DXQNdA10DXQNdA10DXQNdA10D/e0D/ZZH
U9dneHC2ohTqicZ3aeIEj6XuOHimHJ7QaeDwwjhAE8Em/GKnKfMdcSWf6zv8qfKFnT/SNP0/UEsB
Ah4DCgAAAAAATGh1SwAAAAAAAAAAAAAAAAUAGAAAAAAAAAAQAP1BAAAAAGxvZ3MvVVQFAAOH1hNa
dXgLAAEE6wMAAATuAwAAUEsBAh4DFAAAAAgAI2h1S/VMs+5cAQAAGwQAAA0AGAAAAAAAAQAAALSB
PwAAAGxvZ3MvZ2RiLWxvZ3NVVAUAAznWE1p1eAsAAQTrAwAABO4DAABQSwECHgMUAAAACAClO3VL
9CNd35UGAAAAQAAAFgAYAAAAAAABAAAApIHiAQAAbG9ncy9idG1vbl9mYWlsdXJlLmxvZ1VUBQAD
bogTWnV4CwABBOsDAAAE7gMAAFBLAQIeAxQAAAAIAKA7dUstX+T6QxAAAMrIAAAbABgAAAAAAAEA
AACkgccIAABsb2dzL2JsdWV0b290aGRfZmFpbHVyZS5sb2dVVAUAA2SIE1p1eAsAAQTrAwAABO4D
AABQSwUGAAAAAAQABABbAQAAXxkAAAAA

--_002_7B53A3173656CB4190908401FE75F4F8600A8D29exgmbxfz01saske_--
