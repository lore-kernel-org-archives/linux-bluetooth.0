Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: anamtsov@gmail.com
In-Reply-To: <1331512937.14217.74.camel@aeonflux>
References: <1331503837-19015-1-git-send-email-arik@wizery.com> <1331512937.14217.74.camel@aeonflux>
From: Arik Nemtsov <arik@wizery.com>
Date: Mon, 12 Mar 2012 09:39:52 +0200
Message-ID: <CA+XVXfeSUaXiRWNO68VaL7ZkRuJ3g-MxzBvVsViLVPfsNQqM6g@mail.gmail.com>
Subject: Re: [PATCH] mgmt-api: add read Tx power level command
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Mar 12, 2012 at 02:42, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Arik,
>
>> This command reads the Tx power level for a given connected device
>> ---
>> =A0doc/mgmt-api.txt | =A0 28 ++++++++++++++++++++++++++++
>> =A01 files changed, 28 insertions(+), 0 deletions(-)
>>
>> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
>> index 4ede43d..8dae2b4 100644
>> --- a/doc/mgmt-api.txt
>> +++ b/doc/mgmt-api.txt
>> @@ -815,6 +815,34 @@ Unblock Device Command
>> =A0 =A0 =A0 or failure.
>>
>>
>> +Read Tx Power Level Command
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> + =A0 =A0 Command Code: =A0 =A0 =A0 =A0 =A0 0x0028
>
> how is this suppose to work. This command and Set Device ID are suppose
> to have the same command code?

Ah you're right I missed that. I'll put 0x29 then.

>
>> + =A0 =A0 Controller Index: =A0 =A0 =A0 <controller id>
>> + =A0 =A0 Command Parameters: =A0 =A0 Address (6 Octets)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Address_Type (=
1 Octet)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Type (1 Octet)
>> + =A0 =A0 Return Parameters: =A0 =A0 =A0Address (6 Octets)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Address_Type (=
1 Octet)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Status (1 Octe=
t)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Level (1 Octet=
)
>> +
>> + =A0 =A0 Possible values for the Address_Type parameter:
>> + =A0 =A0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 BR/EDR
>> + =A0 =A0 =A0 =A0 =A0 =A0 1 =A0 =A0 =A0 LE Public
>> + =A0 =A0 =A0 =A0 =A0 =A0 2 =A0 =A0 =A0 LE Random
>> +
>> + =A0 =A0 Possible values for the Type parameter:
>> + =A0 =A0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 Current Transmit Power Level
>> + =A0 =A0 =A0 =A0 =A0 =A0 1 =A0 =A0 =A0 Maximum Transmit Power Level
>
> Which ones do you care about? And why not just read both and return both
> at the same time.
>
> I think that I made this pretty clear multiple times already. The mgmt
> API is not for stuffing random HCI commands into it. Please explain your
> usage pattern of the results clearly.
>
> Who is triggering this command and who is consuming the results?

Well the proximity reporter and proximity monitor profiles are the
ones using this (with LE connections only). The proximity monitor can
query the reporter for the Tx power level. The spec claims there's no
point in polling for this, as the value doesn't change during an LE
connection.

Both profiles only care about the current Tx power level. I added the
type for flexibility. It can be removed of course.

In the proposed implementation the reporter reads this value when a
device connects and caches it. When a remote device asks for this
value (via an ATT read as part of the TPS profile), we return the
cached value.

Regards,
Arik
