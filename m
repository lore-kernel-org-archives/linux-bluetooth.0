Return-Path: <amine@baracoda.com>
Message-ID: <33118.82.127.5.232.1081513927.squirrel@baracoda.com>
In-Reply-To: <1081512358.13202.1.camel@pegasus>
References: <C1B29E01A9B748458D51DBBE04E4B9EA2E5628@7layers.7layers-uk.com>
     <33083.82.127.5.232.1081511369.squirrel@baracoda.com>
     <1081512358.13202.1.camel@pegasus>
Date: Fri, 9 Apr 2004 14:32:07 +0200 (CEST)
Subject: Re: [Bluez-devel] Rfcomm problem
From: amine@baracoda.com
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: amine@baracoda.com, "Halam Rose " <halam.rose@7layers-uk.com>,
   "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
List-ID: <bluez-devel.lists.sourceforge.net>

hi,

thanks for your answer, but i found the problem.

i don't execute the script that generate the rfcomm devices.

Regards.

amine

> Hi,
>
>> I have a problem with rfcomm connection.
>> when i try to connect my bluetooth interface using rfcomm it working but
>> i
>> have this message:
>>
>> &Can't open RFCOMM device: No such file or directory
>>
>> and when i connect the interface on second time, i have this message:
>>
>> &Can't connect RFCOMM socket: Connection timed out
>
> what kernel are you using? Are you using udev? Is the /dev/rfcommX
> device node present? What version of the bluez-utils are installed?
>
> Regards
>
> Marcel
>
>
>
