Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 23 Nov 2010 16:06:11 +0800
Message-ID: <AANLkTik+qRFJZJ_Zc6G1-7dxxbaN0XD=c3ALRNuo3KzY@mail.gmail.com>
Subject: How to change the waiting time when building bluetooth connection
From: Roc Bai <buroc83@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2010/11/22 Gustavo F. Padovan <padovan@profusion.mobi>:
> Hi Roc,
>
> * Roc Bai <buroc83@gmail.com> [2010-11-22 11:13:27 +0800]:
>
>> Hi, All:
>>  When i pair my phone with the PC, i have to quickly input the PIN code
>> with the linux-2.6.35.1 kernel. But i can do it slowly with linux-2.6.26
>> kernel. All the application and library are same. So i think the waiting
>> timeout is changed, but i cann't find the changement. I hope get your help
>> on the issue. Thanks very much!
>>
>> My hcid version is 3.36.
>
> Please move to the latest bluez 4 version and then report it again if it
> is the case.

The same phenomenon. But one strange result, some phone can connect
normally, but some phone should input PIN quickly.  But those phones
can work in the old kernel. I think some phones have special
parameters and the changement of new kernel are sensitive with them.
More idea ?
>
> --
> Gustavo F. Padovan
> http://profusion.mobi
>



-- 
------------------------

Thinking before action, but you are wasting time if you don't do action.
