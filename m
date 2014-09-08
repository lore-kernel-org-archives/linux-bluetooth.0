Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <15262F73-F609-40F5-9294-9B35F5CB7C8C@holtmann.org>
References: <CACUGKYNrsWu6k4q193FsLmCc-fMJ955j6TRdnx=LfqFqcQfrmg@mail.gmail.com>
	<15262F73-F609-40F5-9294-9B35F5CB7C8C@holtmann.org>
Date: Mon, 8 Sep 2014 13:47:08 -0700
Message-ID: <CACUGKYNYg=XUXjDZVC9J74bczn+LJEUszH_HtD1Sea7EsWJfdQ@mail.gmail.com>
Subject: Re: Bluetooth certification with bluez stack
From: John Tobias <john.tobias.ph@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

I have a follow up question for you.

1. If I used the PTS tool and (assuming) all the test were passed.
This means I do not have to go to the test house, I could use the PTS
info against my device as evidence that my device comply with the
bluetooth sig requirements and they will recognize it?.

2. Does PTS is enough to verify L2CAP, GAP, SDP, SPP, RFCOMM, AVCTP,
AVDTP and ATT, GATT, SM protocols?.

Regards,

John

On Mon, Sep 8, 2014 at 11:39 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi John,
>
>> We are planning to apply for bluetooth certification and we are using
>> bluez stack. I am gathering more information regarding with the cost.
>>
>> According to my contact, since we are using an opensource bluetooth
>> stack, they need to test all the layers for:
>>
>> 1. Classic BlueZ stack testing:
>>    -> L2CAP, GAP, SDP, SPP, RFCOMM
>>    -> AVCTP and AVDTP
>>
>> 2. LE BlueZ stack:
>>    -> ATT, GATT, SM
>>
>> I would like to know if anyone have done the bluetooth certification
>> using bluez stack and what did you do to lower the cost?.
>
> many companies have qualified BlueZ in different form and shapes. You can=
 find an incomplete list here:
>
> http://www.bluez.org/qualification/
>
> The list is incomplete, because there are many more BlueZ based products =
out there that we do not know enough details about to list them here.
>
> When it comes to qualification, there is no simple answer, however it is =
safe to say that you need to qualify all used protocols and profiles one wa=
y or another. That means either you qualify them all by yourself or you can=
 reference an existing qualification record. However most companies have op=
ted for doing the whole qualification by themselves so they are in control =
of the qualification record.
>
> My advise is that whatever you can test with PTS tool from the Bluetooth =
SIG, you test with it. That lowers your cost a lot since you do not need to=
 go to a test house. If you use the self-listing process with the TPG, you =
can also avoid test house costs. Or you do it the other way around and just=
 contract the whole thing out to a test house.
>
> If you would be qualifying BlueZ for Android (a version of BlueZ running =
on Android devices), then we have full documentation for every single proto=
col and profile. Look at android/{pics,pixit,pts}-*.txt files in the source=
 code. Most of these information will also apply to a generic BlueZ. Howeve=
r we have not had time to unify this kind of qualification documentation.
>
> I bet these information will get you pretty far when it comes to qualific=
ation. They are pretty extensive.
>
> Regards
>
> Marcel
>
