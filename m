Return-Path: <cyrus@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <55108C73-1A7C-45B0-880E-D640BBD81933@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: Nick Pelly <npelly@google.com>
In-Reply-To: <35c90d960901200733q4e655a13h540ff69df932fb0@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] Add -v and -d options to l2ping
Date: Tue, 20 Jan 2009 16:40:21 +0100
References: <20090107021925.0B49537A5CE@localhost> <1232294188.5095.30.camel@californication> <35c90d960901200733q4e655a13h540ff69df932fb0@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nick,

>>> --- a/tools/l2ping.c  2008-08-29 15:42:24.000000000 -0700
>>> +++ b/tools/l2ping.c  2009-01-06 17:26:29.000000000 -0800
>>> @@ -51,6 +51,7 @@
>>> static int count   = -1;
>>> static int timeout = 10;
>>> static int reverse = 0;
>>> +static int verify = 0;
>>
>> patch has been applied, but I need another one from you that  
>> updates the
>> manpage for l2ping. They always come together. Please remember that.
>
> Sorry for the omission. Man page patch coming up.
>
> I notice you did not include the explanation that not all remote
> stacks will send the request payload back in the response (and that is
> fine by the spec). Do you want this in the man page?

exactly. That belongs in the manpage :)

Regards

Marcel

