Return-Path: <cyrus@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <7B1632C9-FE1A-43EA-A0B6-F26A46F9929F@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: Bastien Nocera <hadess@hadess.net>
In-Reply-To: <1237816742.19118.1234.camel@cookie.hadess.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] Re: Work-around for broken MS device
Date: Mon, 23 Mar 2009 16:45:26 +0100
References: <1236278908.3602.1896.camel@cookie.hadess.net> <1237397279.15346.1157.camel@cookie.hadess.net> <1237011673.24751.10.camel@localhost.localdomain> <1237816742.19118.1234.camel@cookie.hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

>>>> As seen in https://bugzilla.redhat.com/show_bug.cgi?id=450081
>>>> The Microsoft Wireless Notebook Presenter Mouse 8000 has its name  
>>>> in
>>>> ISO-8859-1 instead of UTF-8, as required by the BT spec.
>>>>
>>>> I've implemented a small work-around. This isn't very invasive,  
>>>> IMO, as
>>>> we already do UTF-8 checks.
>>>>
>>>> In my tests, this makes the mouse show up as:
>>>> Microsoft® Wireless Notebook Presenter Mouse 8000
>>>
>>> Attached is patch in the proper format.
>>
>> I see the need for this one, but just a failing UTF-8 check to  
>> assume we
>> are using ISO-8859-1 is not good enough. Since the mouse has a DID
>> record, can we tie this together with the VID and PID?
>
> In those kind of cases, we can only guess what the encoding would  
> be, we
> can't detect those encodings reliably. Given that we fallback to the  
> old
> behaviour when the device, and that ISO-8859-X corresponds 1-1 with
> UTF-8 for the ASCII characters, I don't think it's such a stretch to
> think that American companies (who'd be using ISO-8859-1) would be the
> worst offenders for this sort of mistake.
>
> I don't think special casing only this device would be a good idea.  
> As I
> mentioned, I reproduced the bug by making my computer, running BlueZ,
> adopt that name.

can we just fallback to ASCII only? Looks better to me than assuming  
Latin-1. We replace invalid characters with spaces in that case.

Regards

Marcel

