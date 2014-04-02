Return-Path: <cyrus@holtmann.org>
Message-ID: <533C12B9.1080601@openbossa.org>
Date: Wed, 02 Apr 2014 10:38:01 -0300
From: Andre Guedes <andre.guedes@openbossa.org>
MIME-Version: 1.0
To: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC] doc: Connection Parameters Command
References: <1395703047-5743-1-git-send-email-andre.guedes@openbossa.org>	<20140328161549.GA16919@t440s.P-661HNU-F1> <CAN_7+YZV=5TRx=xG-iEQz0+i+89-Ubo5OBxuE-tF_e7qCKu4Mg@mail.gmail.com>
In-Reply-To: <CAN_7+YZV=5TRx=xG-iEQz0+i+89-Ubo5OBxuE-tF_e7qCKu4Mg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On 03/30/2014 04:00 AM, Lukasz Rymanowski wrote:
> HI Andre,
>
> On Fri, Mar 28, 2014 at 5:15 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> Hi Andre,
>>
>> On Mon, Mar 24, 2014, Andre Guedes wrote:
>>> This patch introduces commands to add and remove connection parameters.
>>> ---
>>>   doc/mgmt-api.txt | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>>   1 file changed, 83 insertions(+), 1 deletion(-)
>>
>> All in all this looks pretty good to me. Just one thing I'd fix:
>>
>>> +Add Connection Parameters Command
>>> +====================================
>>> +
>>> +     Command Code:           0x0032
>>> +     Controller Index:       <controller id>
>>> +     Command Parameters:     Address (6 Octets)
>>> +                             Address_Type (1 Octet)
>>> +                             Auto_Connect_Option (1 Octet)
>>> +                             Min_Connection_Interval (2 Octets)
>>> +                             Max_Connection_Interval (2 Octes)
>>> +     Return Parameters:
>>> +
>>
>> This should have the Address and Address_Type also in the return
>> parameters for consistency and ability to distinguish the completion of
>> two simultaneous commands for the different devices.
>
> In addition to what Johan wrote, maybe you should send Command
> Complete event on both success and failure.
> So you always get the address information in userspace.

Yes, sure.

Thanks,

Andre
