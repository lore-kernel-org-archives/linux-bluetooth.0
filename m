Return-Path: <yunhanw@google.com>
MIME-Version: 1.0
In-Reply-To: <CALvjcs8UK5Lik=CvU-vYzZ2=nrQh+BKy21isgs2Xh_yq4q9svA@mail.gmail.com>
References: <20170823225839.461-1-yunhanw@google.com> <D2A056DB-B533-4CAC-BCB8-19C39760E05F@holtmann.org>
 <CALvjcs-b3M9A6sdy80pakUwRHxBueuxpxvrpZt2SBhz=xDTK6g@mail.gmail.com>
 <CALvjcs-0POiT-inDdF8oxheHL=z6acK5E03QRtUwbHZnxcf37Q@mail.gmail.com> <CALvjcs8UK5Lik=CvU-vYzZ2=nrQh+BKy21isgs2Xh_yq4q9svA@mail.gmail.com>
From: Yunhan Wang <yunhanw@google.com>
Date: Sun, 24 Sep 2017 21:17:03 -0700
Message-ID: <CALvjcs8rzxTCLP72GoiCmEBw7H=rDzreP+c_NytL-2weCRXT6Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ] build: use abspath for lib/bluetooth
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

Can anyone take a further review?

Thanks
Best wishes
Yunhan

On Thu, Sep 21, 2017 at 11:11 AM, Yunhan Wang <yunhanw@google.com> wrote:
> Hi, Marcel
>
> Ping for any other concern?
>
> Thanks
> Best wishes
> Yunhan
>
> On Tue, Sep 19, 2017 at 10:55 PM, Yunhan Wang <yunhanw@google.com> wrote:
>> Hi, Marcel
>>
>> Any other concern on this patch?
>>
>> Thanks
>> Best wishes
>> Yunhan
>>
>> On Mon, Sep 18, 2017 at 9:47 PM, Yunhan Wang <yunhanw@google.com> wrote:
>>> Hi, Marcel
>>>
>>> I just run make distcheck, it is working with this change upon latest m=
aster.
>>>
>>> Could you help to apply it?
>>>
>>> The below are detailed step.
>>> 1. ./configure --prefix=3D/usr --mandir=3D/usr/share/man --sysconfdir=
=3D/etc
>>> --localstatedir=3D/var --enable-experimental
>>> --with-systemdsystemunitdir=3D/lib/systemd/system
>>> --with-systemduserunitdir=3D/usr/lib/systemd --enable-deprecated
>>> --enable-tools --enable-testing --enable-experimental
>>> 2. make distcheck
>>>
>>> Thanks
>>> Best wishes
>>> Yunhan
>>>
>>> On Mon, Aug 28, 2017 at 10:08 PM, Marcel Holtmann <marcel@holtmann.org>=
 wrote:
>>>> Hi Yunhan,
>>>>
>>>>> When building from out of tree, and the top build dir was specified a=
s
>>>>> an absolute path, the linked headers in ${builddir}/lib/bluetooth wer=
e
>>>>> broken.  This patch fixes it by relying on make's abspath macro as
>>>>> opposed to the path concatenation.
>>>>> ---
>>>>> Makefile.am | 2 +-
>>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/Makefile.am b/Makefile.am
>>>>> index eaed632e8..ad638cbb2 100644
>>>>> --- a/Makefile.am
>>>>> +++ b/Makefile.am
>>>>> @@ -499,7 +499,7 @@ $(lib_libbluetooth_la_OBJECTS): $(local_headers)
>>>>>
>>>>> lib/bluetooth/%.h: lib/%.h
>>>>>       $(AM_V_at)$(MKDIR_P) lib/bluetooth
>>>>> -     $(AM_V_GEN)$(LN_S) -f "$(abs_top_builddir)"/$< $@
>>>>> +     $(AM_V_GEN)$(LN_S) -f $(abspath $<) $@
>>>>
>>>> does =E2=80=9Cfakeroot make distcheck=E2=80=9D still works when doing =
this change?
>>>>
>>>> Regards
>>>>
>>>> Marcel
>>>>
