Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1232294188.5095.30.camel@californication>
References: <20090107021925.0B49537A5CE@localhost>
	 <1232294188.5095.30.camel@californication>
Date: Tue, 20 Jan 2009 07:33:00 -0800
Message-ID: <35c90d960901200733q4e655a13h540ff69df932fb0@mail.gmail.com>
Subject: Re: [PATCH] Add -v and -d options to l2ping
From: Nick Pelly <npelly@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, Jan 18, 2009 at 7:56 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Nick,
>
>> --- a/tools/l2ping.c  2008-08-29 15:42:24.000000000 -0700
>> +++ b/tools/l2ping.c  2009-01-06 17:26:29.000000000 -0800
>> @@ -51,6 +51,7 @@
>>  static int count   = -1;
>>  static int timeout = 10;
>>  static int reverse = 0;
>> +static int verify = 0;
>
> patch has been applied, but I need another one from you that updates the
> manpage for l2ping. They always come together. Please remember that.

Sorry for the omission. Man page patch coming up.

I notice you did not include the explanation that not all remote
stacks will send the request payload back in the response (and that is
fine by the spec). Do you want this in the man page?

>
> Regards
>
> Marcel
>
>
>
