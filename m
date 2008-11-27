Return-Path: <cyrus@holtmann.org>
Message-ID: <492F28EF.7090506@koala.ie>
Date: Thu, 27 Nov 2008 23:10:39 +0000
From: Simon Kenyon <simon@koala.ie>
MIME-Version: 1.0
To: Bastien Nocera <hadess@hadess.net>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Sony BD Remote (help requested)
References: <492E6E6A.80509@koala.ie> <1227783396.27994.1750.camel@cookie.hadess.net>
In-Reply-To: <1227783396.27994.1750.camel@cookie.hadess.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Bastien Nocera wrote:
> On Thu, 2008-11-27 at 09:54 +0000, Simon Kenyon wrote:
>   
>> i'm trying to get y BD Remote to work.
>>
>> this is what i have done so far:
>>
>> installed bluez from git (as of yesterday)
>> configured it (i think)
>> when i:
>>
>> hidd --search
>>
>> i see the remote
>>     
>
> Your remote won't work using hidd. There's no code in hidd to decode the
> custom protocol.
>
> Pair it with the bluetooth-wizard and you can be on your way.
>
> Cheers
>
>   
but when i run bluetooth-wizard nothing is shown
