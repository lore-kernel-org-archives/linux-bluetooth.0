Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAFBvHif+xS12ywGEUdpycTtU--TVZSTgAb4mJuN_O5NKJSz36w@mail.gmail.com>
References: <1352449889-5149-1-git-send-email-s.syam@samsung.com>
	<1352457867.16204.9.camel@aeonflux>
	<CAFBvHif+xS12ywGEUdpycTtU--TVZSTgAb4mJuN_O5NKJSz36w@mail.gmail.com>
Date: Wed, 14 Nov 2012 18:33:51 +0530
Message-ID: <CAFBvHidHO27JLpwJRs1mbieSqbKFJ88PVt1jL_CCON_zURDozg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] build: Require D-Bus 1.5 or later
From: Syam Sidhardhan <syamsidhardh@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Nov 13, 2012 at 10:01 PM, Syam Sidhardhan
<syamsidhardh@gmail.com> wrote:
> Hi Marcel,
>
> On Fri, Nov 9, 2012 at 4:14 PM, Marcel Holtmann <marcel@holtmann.org> wro=
te:
>> Hi Syam,
>>
>>> The gdbus require D-Bus 1.5 version.
>>>
>>> Log:
>>>   CC     gdbus/object.o
>>> gdbus/object.c: In function =E2=80=98properties_set=E2=80=99:
>>> gdbus/object.c:876:7: error: =E2=80=98DBUS_ERROR_UNKNOWN_PROPERTY=E2=80=
=99 undeclared
>>>  (first use in this function)
>>> gdbus/object.c:876:7: note: each undeclared identifier is reported
>>>  only once for each function it appears in
>>> gdbus/object.c:881:6: error: =E2=80=98DBUS_ERROR_PROPERTY_READ_ONLY=E2=
=80=99
>>>  undeclared (first use in this function)
>>> make[1]: *** [gdbus/object.o] Error 1
>>> make: *** [all] Error 2
>>
>> if they are still simple defines, then lets just #ifndef them and define
>> them in gdbus/object.c
>>
>
> Yes, those are simple defines. I'll send a patch according to your sugges=
tion.
>

Missing the mailing list in my earlier reply. CC-ing here.

Regards,
Syam.
