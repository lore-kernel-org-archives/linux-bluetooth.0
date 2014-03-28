Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140328082222.GA2138@t440s.lan>
References: <1395994200-23071-1-git-send-email-lukasz.rymanowski@tieto.com>
	<20140328082222.GA2138@t440s.lan>
Date: Fri, 28 Mar 2014 11:06:41 +0100
Message-ID: <CAMudyAv0PHTDuq+gJes+==D5AiivRycoEzDhOZ1ED-wtT9rAYw@mail.gmail.com>
Subject: Re: [RFC v2] mgmt-api: Add support for Read Remote RSSI
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 28 March 2014 09:22, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Lukasz,
>
> On Fri, Mar 28, 2014, Lukasz Rymanowski wrote:
>> +Start Read Remote RSSI Command
>> +==============================
>> +
>> +     Command Code:           0x0031
>> +     Controller Index:       <controller id>
>> +     Command Parameters:     Address (6 Octets)
>> +                             Address_Type (1 Octet)
>> +                             Threshold (1 Octet)
>> +     Return Parameters:      Address (6 Octets)
>> +                             Address_Type (1 Octet)
>> +                             Current_RSSI (1 Octet)
>> +
>> +     This command is used to start read remote rssi with given
>> +     threshold. On this command current remote RSSI is read and
>> +     is used as starting point for messurements. If threshold is
>> +     exceeded then Remote RSSI Changed event is sent.
>> +
>> +     If threshold is 0 then no Remote RSSI Changed event is generated but
>> +     only Command Complete with current RSSI.
>> +
>> +     This command can be used only when controller is powered on.
>> +
>> +     This command generates a Command Complete event on success
>> +     and on failure.
>> +
>> +     Possible errors:        Not Connected
>> +                             Invalid Parameters
>> +                             Not Powered
>> +                             Invalid Index
>
> Should you mention that a disconnection has the same effect as a Stop
> Read Remote RSSI Command? Or will the request be remembered and resumed
> when the same device gets connected again?
>

Yes, it this idea, disconnection has same effect as a Stop Read Remote
RSSI Command. If we go with this approach I will add such a comment.

>> +Stop Read Remote RSSI Command
>> +=============================
>> +
>> +     Command Code:           0x0032
>> +     Controller Index:       <controller id>
>> +     Command Parameters:     Address (6 Octets)
>> +                             Adress_Type (1 Octet)
>> +
>> +     Return Parametes:
>> +
>
> You should have the Address and Address_Type in the return parameters as
> well. Otherwise it's not possible to know what command completed if you
> issue the same command for two separate connections simultaneously (it's
> also a matter of consistency with everything else in the mgmt API).

Fixed
>
> Johan

\Łukasz
