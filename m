Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [RFC] need for new scan api for bluetooth low energy.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHrH25QZeN+biT4GBCTpPTSLfP2ABx5DVOYeyPMwCQg=iT9jjA@mail.gmail.com>
Date: Tue, 30 Sep 2014 19:24:26 +0200
Cc: Jakub Pawlowski <jpawlowski@google.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	Scott James Remnant <keybuk@google.com>
Message-Id: <82BA6E2B-B502-46DF-B5E8-052B8D9251FB@holtmann.org>
References: <CAD0=r8yozB8eMdJOuffUeQZVFVf5xEXnP5tCt+k3m0e9wzMxiA@mail.gmail.com> <735FD32E-BD15-4CE1-8D9C-44B8EC56DF7A@holtmann.org> <CAHrH25Q6XqsLjGyfoXwimrap9=kKHOQn-G=k4Fz6HXmEPJ7EtQ@mail.gmail.com> <20140917051457.GA4671@t440s.P-661HNU-F1> <CAD0=r8x-=O7XAqQF_wBHQEqSkfifzgWW2AagW2EvsDUtM-E_ow@mail.gmail.com> <20140917065252.GA5554@t440s.lan> <CAD0=r8z9g+F7Z9X_8PE4jk3JbA+oLj9Of33RSqxiRd0dn9AnXQ@mail.gmail.com> <8868B74C-0DDD-43C1-BCBF-2578A700EF72@holtmann.org> <CAD0=r8xQzhizXo4umQ_mG_WMH7Akp4bji-9PNRGzqj-7HWnyNA@mail.gmail.com> <0EA633E6-A0F5-4F67-B421-9857466C1175@holtmann.org> <CAD0=r8w035mLnWTKtEfxZ7agzwTFRO9dsv+6qdafcBG7RYzYDQ@mail.gmail.com> <F673E928-258E-47F7-B71A-F32410974538@holtmann.org> <CAD0=r8xMcGP-Hjt8uCSY9Qx9VJLov5scSwRTvFr3PAaOXXbyzQ@mail.gmail.com> <CAD0=r8zcPCWKyTQLQeG68uA21_sEv+5wDKNB-GJzgS1+BcD+bQ@mail.gmail.com> <372D8399-BFC6-413F-924F-44CE79030516@holtmann.org> <CAHrH25QZeN+biT4GBCTpPTSLfP2ABx5DVOYeyPMwCQg=iT9jjA@mail.gmail.com>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

>>> +Advertisement Received Event
>>> +==============================
>>> +
>>> + Event Code: 0x0020
>>> + Controller Index: <controller id>
>>> + Event Parameters: Address (6 Octets)
>>> + Address_Type (1 Octet)
>>> + RSSI (1 Octet)
>>> + Flags (4 Octets)
>>> + AD_Data_Length (2 Octets)
>>> + AD_Data (0-65535 Octets)
>> 
>> Device Found event not good enough here? Why would you need a new event with exactly the same parameters?
>> 
> 
> I guess the idea with this one is that it won't have duplicate
> filtering, right? And all AD_IND types will be propagated instead of
> just connectable ones, which is how this one differs from Device
> Found. And I'm guessing AD_Data here is the data in the advertisement
> packet in general as opposed to only being limited to EIR data.
> Though, correct me if I'm wrong.

we fixed the advertising type handling. Device Found will report ADV_IND, ADV_NONCONN_IND and ADV_SCAN_IND. The latter two have the Non-Connectable flag set.

Regards

Marcel

