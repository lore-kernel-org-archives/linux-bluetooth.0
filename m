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
Date: Tue, 30 Sep 2014 10:15:36 -0700
Message-ID: <CAHrH25QZeN+biT4GBCTpPTSLfP2ABx5DVOYeyPMwCQg=iT9jjA@mail.gmail.com>
Subject: Re: [RFC] need for new scan api for bluetooth low energy.
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Jakub Pawlowski <jpawlowski@google.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	Scott James Remnant <keybuk@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,


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
>

I guess the idea with this one is that it won't have duplicate
filtering, right? And all AD_IND types will be propagated instead of
just connectable ones, which is how this one differs from Device
Found. And I'm guessing AD_Data here is the data in the advertisement
packet in general as opposed to only being limited to EIR data.
Though, correct me if I'm wrong.

Cheers,
Arman
