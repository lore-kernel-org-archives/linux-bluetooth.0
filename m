Return-Path: <loic.poulain@linaro.org>
MIME-Version: 1.0
In-Reply-To: <1503e15d-6199-221a-542f-3766a69577e5@redhat.com>
References: <1507710734-32520-1-git-send-email-frederic.danis.oss@gmail.com>
 <20171011090354.GS4269@localhost> <CAJZ5v0jPEg5Ow4p0DzPJ9Md7RUTPhZZqCzqP5zmX-pPf9N80=g@mail.gmail.com>
 <AA38D4FD-5A35-460D-85CF-380BAB933448@holtmann.org> <ac53458d-c910-2d0a-a2ad-e7d21f8a5be7@gmail.com>
 <20171018145608.GB27138@kroah.com> <20171019142354.GE5638@localhost>
 <877ea825-eec5-d982-f962-d67067749009@redhat.com> <115502FA-19DE-439C-A171-3CD5E6D92338@holtmann.org>
 <1503e15d-6199-221a-542f-3766a69577e5@redhat.com>
From: Loic Poulain <loic.poulain@linaro.org>
Date: Thu, 19 Oct 2017 18:15:40 +0200
Message-ID: <CAMZdPi_ZpNrdjJPnS_rQ9t3oYe6+en9oHQMjmMjx_xHL-WWZKQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] ACPI serdev support
To: Hans de Goede <hdegoede@redhat.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <greg@kroah.com>, =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis.oss@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Loic Poulain <loic.poulain@gmail.com>, Lukas Wunner <lukas@wunner.de>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: multipart/alternative; boundary="f403045c03ba47c6bb055be8adf2"
List-ID: <linux-bluetooth.vger.kernel.org>

--f403045c03ba47c6bb055be8adf2
Content-Type: text/plain; charset="UTF-8"

Hi


Hmm, I've never actually seen any hardware use an intel BT HCI connected
>>> to a serdev, but I guess people did not write that code for fun, so those
>>> do exist ?
>>>
>>
>> they are all ACPI based and could now start using serdev. Previously they
>> were all driven by btattach.
>>
>
> I understand, I was just wondering if anyone is aware of any hardware
> actually using Intel BT devices in this manner, because it is going
> to be tricky to do a similar series if we cannot test it.
>

Yeah this driver supports Lightning-Peak iBT 3.0 UART controller.
I remember this controller comes (at least) with Atom x3-c3440 / x3-c3445
SoCs.
However I don't have the hardware anymore.

Regards,
Loic

--f403045c03ba47c6bb055be8adf2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi<br><br><br><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex"><div><div class=3D"gmail-h5"><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Hmm, I&#39;ve never actually seen any hardware use an intel BT HCI connecte=
d<br>
to a serdev, but I guess people did not write that code for fun, so those<b=
r>
do exist ?<br>
</blockquote>
<br>
they are all ACPI based and could now start using serdev. Previously they w=
ere all driven by btattach.<br>
</blockquote>
<br></div></div>
I understand, I was just wondering if anyone is aware of any hardware<br>
actually using Intel BT devices in this manner, because it is going<br>
to be tricky to do a similar series if we cannot test it.<br></blockquote><=
div><br></div><div>Yeah this driver supports Lightning-Peak iBT 3.0 UART co=
ntroller.</div><div>I remember this controller comes (at least) with Atom x=
3-c3440 / x3-c3445 SoCs.<br></div><div>However I don&#39;t have the hardwar=
e anymore.</div><div><br></div><div>Regards,</div>Loic<div><br></div><div c=
lass=3D"gmail_extra"><div class=3D"gmail_quote"><div> <br></div></div></div=
></div>

--f403045c03ba47c6bb055be8adf2--
