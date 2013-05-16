Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <9C2AAC1D-11FF-42B4-8658-0FFBC50A2A46@holtmann.org>
References: <1368712856-30692-1-git-send-email-anderson.lizardo@openbossa.org>
	<9C2AAC1D-11FF-42B4-8658-0FFBC50A2A46@holtmann.org>
Date: Thu, 16 May 2013 12:19:18 -0400
Message-ID: <CAJdJm_NBJpoovNRkECuVGLB6pmdhNMGKQas4af9Y70BKKsPU3Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ] plugins: Fix compilation error on autopair
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, May 16, 2013 at 10:07 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
>>       f = fopen("/dev/urandom", "rb");
>>       if (f != NULL) {
>> -             fread(&seed, sizeof(seed), 1, f);
>> +             nread = fread(&seed, sizeof(seed), 1, f);
>>               fclose(f);
>>       }
>>
>> +     if (f == NULL || nread != 1)
>> +             seed = time(NULL);
>> +
>>       srand(seed);
>
> lets redo this in actually readable code ;)
>
> Checking f twice is not acceptable. And I still wonder why fopen() is here preferred over open().

I just sent another version that uses open()/read() instead.
Compilation tested only.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
