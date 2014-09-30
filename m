Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <372D8399-BFC6-413F-924F-44CE79030516@holtmann.org>
References: <CAD0=r8yozB8eMdJOuffUeQZVFVf5xEXnP5tCt+k3m0e9wzMxiA@mail.gmail.com>
	<735FD32E-BD15-4CE1-8D9C-44B8EC56DF7A@holtmann.org>
	<CAHrH25Q6XqsLjGyfoXwimrap9=kKHOQn-G=k4Fz6HXmEPJ7EtQ@mail.gmail.com>
	<20140917051457.GA4671@t440s.P-661HNU-F1>
	<CAD0=r8x-=O7XAqQF_wBHQEqSkfifzgWW2AagW2EvsDUtM-E_ow@mail.gmail.com>
	<20140917065252.GA5554@t440s.lan>
	<CAD0=r8z9g+F7Z9X_8PE4jk3JbA+oLj9Of33RSqxiRd0dn9AnXQ@mail.gmail.com>
	<8868B74C-0DDD-43C1-BCBF-2578A700EF72@holtmann.org>
	<CAD0=r8xQzhizXo4umQ_mG_WMH7Akp4bji-9PNRGzqj-7HWnyNA@mail.gmail.com>
	<0EA633E6-A0F5-4F67-B421-9857466C1175@holtmann.org>
	<CAD0=r8w035mLnWTKtEfxZ7agzwTFRO9dsv+6qdafcBG7RYzYDQ@mail.gmail.com>
	<F673E928-258E-47F7-B71A-F32410974538@holtmann.org>
	<CAD0=r8xMcGP-Hjt8uCSY9Qx9VJLov5scSwRTvFr3PAaOXXbyzQ@mail.gmail.com>
	<CAD0=r8zcPCWKyTQLQeG68uA21_sEv+5wDKNB-GJzgS1+BcD+bQ@mail.gmail.com>
	<372D8399-BFC6-413F-924F-44CE79030516@holtmann.org>
Date: Tue, 30 Sep 2014 10:25:10 -0700
Message-ID: <CAD0=r8x2bub9E+ohicwfxK0AAykRTUSrrTjAD-tFv-aj7xGoww@mail.gmail.com>
Subject: Re: [RFC] need for new scan api for bluetooth low energy.
From: Jakub Pawlowski <jpawlowski@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Arman Uguray <armansito@chromium.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>, Scott James Remnant <keybuk@google.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Sep 30, 2014 at 10:01 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Jakub,
>
>> ---
>> doc/mgmt-api.txt | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 69 insertions(+)
>>
>> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
>> index 11e2490..1c78f1c 100644
>> --- a/doc/mgmt-api.txt
>> +++ b/doc/mgmt-api.txt
>> @@ -2135,6 +2135,34 @@ Set Public Address Command
>>  Invalid Index
>>
>>
>> +Start LE Filtered Device Scan
>> +=======================
>> +
>> + Command Code: 0x003A
>> + Controller Index: <controller id>
>> + Command Parameters: UUID (16 Octets)
>> +             max_pathloss (1 octet)
>> +             is_active (1 octet)
>> +
>> + Return Parameters:
>> +
>> + This command starts LE scan, and filter received advertisements: if
>> AD contains both TX power level and Service Solicitation, and UUID is
>> contained in Service Solicitation and computed pathloss is smaller
>> than max_pathloss parameter, then a Advertisement Received event will
>> be sent.
>> +
>> + Possible values for the is_active parameter:
>> + 0 Start passive scan
>> + 1 Start active scan
>
> is really like a one-shot scan? Or is this something you would be running all the time in the background?
>
> Fundamentally if it is one-shot thing then you always want to do active scan, but if it runs in the background then you only want to do passive scanning.

I'm working on two projects, one require scanning up to 2 minutes,
second requires long term scanning in background.
I'd preffer to have scan type as argument, but having only passive
scan is also good option for me.

>
>> +
>> + This command can only be used when the controller is powered.
>> +
>> + This command generates a Command Complete event on success or failure.
>> +
>> + Possible errors: Busy
>> + Not Supported
>> + Invalid Parameters
>> + Not Powered
>> + Invalid Index
>> +
>> +
>> Command Complete Event
>> ======================
>>
>> @@ -2851,3 +2879,44 @@ New Configuration Options Event
>>
>>  This event indicates that one or more of the options for the
>>  controller configuration has changed.
>> +
>> +
>> +Advertisement Received Event
>> +==============================
>> +
>> + Event Code: 0x0020
>> + Controller Index: <controller id>
>> + Event Parameters: Address (6 Octets)
>> + Address_Type (1 Octet)
>> + RSSI (1 Octet)
>> + Flags (4 Octets)
>> + AD_Data_Length (2 Octets)
>> + AD_Data (0-65535 Octets)
>
> Device Found event not good enough here? Why would you need a new event with exactly the same parameters?

Because Device Found event always contains EIR data, and mine would
sometimes contain only AD data.
Also this will be send for each advertisement received, not for first one only.

>
> Regards
>
> Marcel
>
