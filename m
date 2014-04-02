Return-Path: <cyrus@holtmann.org>
Message-ID: <533C124A.7070606@openbossa.org>
Date: Wed, 02 Apr 2014 10:36:10 -0300
From: Andre Guedes <andre.guedes@openbossa.org>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC] doc: Connection Parameters Command
References: <1395703047-5743-1-git-send-email-andre.guedes@openbossa.org> <20140328161549.GA16919@t440s.P-661HNU-F1>
In-Reply-To: <20140328161549.GA16919@t440s.P-661HNU-F1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 03/28/2014 01:15 PM, Johan Hedberg wrote:
> Hi Andre,
>
> On Mon, Mar 24, 2014, Andre Guedes wrote:
>> This patch introduces commands to add and remove connection parameters.
>> ---
>>   doc/mgmt-api.txt | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 83 insertions(+), 1 deletion(-)
>
> All in all this looks pretty good to me. Just one thing I'd fix:
>
>> +Add Connection Parameters Command
>> +====================================
>> +
>> + Command Code: 0x0032
>> + Controller Index: <controller id>
>> + Command Parameters: Address (6 Octets)
>> + Address_Type (1 Octet)
>> + Auto_Connect_Option (1 Octet)
>> + Min_Connection_Interval (2 Octets)
>> + Max_Connection_Interval (2 Octes)
>> + Return Parameters:
>> +
>
> This should have the Address and Address_Type also in the return
> parameters for consistency and ability to distinguish the completion of
> two simultaneous commands for the different devices.

Fair enough, I'll do it in next version.

Thanks,

Andre
