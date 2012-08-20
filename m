Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLNQUEiXgt1=TfoOE+fEigm4aNJR9haWAdNPMfPayH3CQ@mail.gmail.com>
References: <1345272662-2850-1-git-send-email-lucas.demarchi@profusion.mobi> <CABBYNZLNQUEiXgt1=TfoOE+fEigm4aNJR9haWAdNPMfPayH3CQ@mail.gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Mon, 20 Aug 2012 10:51:38 -0300
Message-ID: <CAMOw1v6S9z=Mr7SYX0any-q_n_9ReetXVnpqG_NFk1U5iQKzYQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 00/15] gdbus: DBus.Properties + ObjectManager
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Aug 20, 2012 at 4:56 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Lucas,
>
> On Sat, Aug 18, 2012 at 9:50 AM, Lucas De Marchi
> <lucas.demarchi@profusion.mobi> wrote:
>> Hey,
>>
>> here is a third version of the changes planned to gdbus. In contrary to
>> previous versions, this patch set includes also the Object Manager, since the
>> PropertiesChanged signal was made on top of it.
>>
>> The first two patches are cosmetics to the other ones and somehow independent.
>>
>> The last two patches are examples on how we would use the API after the conversion.
>>
>> DBus.Properties.Set() is async now. We pass the message on so user can use it
>> to create the reply or error message.
>
> Another thing we discussed was getter to be async as well, but this
> had several implications:
>
> 1. Properties should be cacheable and by that it means the client can
> listen to PropertiesChanged after it knows about the initial value.
>
> 2. In case of GetAll and GetManagedObjects where all properties are
> fetched it would be extremely difficult to deal with getter being
> async, each property could cause a delay in the response and in the
> meantime the properties already fetched could have changed.
>
> 3. The error cases, when the getter fails, are complicated even more
> by libdbus not supporting changes to its items already in the
> iterator, so we would have to workaround this.
>
> So a property which the value is initially unknown by server should
> either be omitted or don't be exported as a property if the value
> cannot be cached consistently.

Additionally, we don't have async GetProperties in Bluez right now
("git grep METHOD | grep GetProperties"), so there's no urge need for
them. The one project that uses async GetProperties is oFono. I
propose we go with the simpler approach, letting the getter be sync
and when time comes to convert oFono we can think about how to handle
it (if we are not already using ell).



Lucas De Marchi
