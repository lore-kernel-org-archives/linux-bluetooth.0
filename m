Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <51DF00FF-73E9-4E94-A89A-86EBD7220068@holtmann.org>
References: <614A5683-0763-4E64-B178-67577793D8EF@holtmann.org>
	<51DF00FF-73E9-4E94-A89A-86EBD7220068@holtmann.org>
Date: Fri, 9 Oct 2015 08:39:16 -0700
Message-ID: <CAD0=r8zXmQMUgJemFtAjUSfgXpgrBkeGaz_G+z4N=zL47JU3-A@mail.gmail.com>
Subject: Re: Issue with new LE connection creation
From: Jakub Pawlowski <jpawlowski@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Oct 9, 2015 at 8:32 AM, Marcel Holtmann <marcel@holtmann.org> wrote=
:
> Hi,
>
>> so when I try to connect a LE L2CAP connection to a device that does not=
 exist and then abort it will not have reached the timeout, I get this:
>>
>> < HCI Command: LE Add Device To White List (0x08|0x0011) plen 7
>>        Address type: Public (0x00)
>>        Address: 11:22:33:44:55:66 (OUI 11-22-33)
>>> HCI Event: Command Complete (0x0e) plen 4
>>      LE Add Device To White List (0x08|0x0011) ncmd 1
>>        Status: Success (0x00)
>> < HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
>>        Type: Passive (0x00)
>>        Interval: 60.000 msec (0x0060)
>>        Window: 30.000 msec (0x0030)
>>        Own address type: Public (0x00)
>>        Filter policy: Ignore not in white list (0x01)
>>> HCI Event: Command Complete (0x0e) plen 4
>>      LE Set Scan Parameters (0x08|0x000b) ncmd 1
>>        Status: Success (0x00)
>> < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
>>        Scanning: Enabled (0x01)
>>        Filter duplicates: Enabled (0x01)
>>> HCI Event: Command Complete (0x0e) plen 4
>>      LE Set Scan Enable (0x08|0x000c) ncmd 1
>>        Status: Success (0x00)
>> < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
>>        Scanning: Disabled (0x00)
>>        Filter duplicates: Disabled (0x00)
>>> HCI Event: Command Complete (0x0e) plen 4
>>      LE Set Scan Enable (0x08|0x000c) ncmd 1
>>        Status: Success (0x00)
>> < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
>>        Scanning: Disabled (0x00)
>>        Filter duplicates: Disabled (0x00)
>>> HCI Event: Command Complete (0x0e) plen 4
>>      LE Set Scan Enable (0x08|0x000c) ncmd 1
>>        Status: Command Disallowed (0x0c)
>>
>> Notice the two attempts for disabling scanning. We should not do that. T=
his is clearly a bug. This can be easily reproduced with latest bluetooth-n=
ext and this command:
>>
>> l2test -V le_public -n 11:22:33:44:55:66
>>
>> The same happens when you are waiting for the socket connect timeout. Th=
e scanning disable command is sent twice.

I think my code is causing that, will send patch with fix in few minutes...

>>
>> I also had a case where the disabling of the scanning is not sent at all=
 and the controller kept scanning. However for that one, I do not have an e=
asy way to reproduce it. But it is essentially the same case, you close the=
 socket / application before the connection has been established.
>
> in addition when a connect() for LE L2CAP socket call times out, we get a=
n invalid module reference count.
>
> bluetooth             532480  1
> rfkill                 24576  1 bluetooth
>
> I see it left with an extra reference count. This is pretty bad and shows=
 that something is clearly wrong.
>
> Regards
>
> Marcel
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
