Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAKT1EBcaK2KkpSs=jznV1e8UbGA9bv3nWyx79d1c=YOxbr25dA@mail.gmail.com>
References: <CACLukzJSY0dXp8Ns5bRARN6OwWUh+_474NS5jEQ4mD-85Nxh0w@mail.gmail.com>
	<CAJdJm_PaGa7Q-nmHx341FT8Qr-KzV1197Vc383P4tsdmHg8BKg@mail.gmail.com>
	<CAKT1EBcaK2KkpSs=jznV1e8UbGA9bv3nWyx79d1c=YOxbr25dA@mail.gmail.com>
Date: Wed, 6 Jul 2011 08:51:56 -0400
Message-ID: <CAJdJm_OqZ2LwF3so2fYxXRpiv3gRHPkCUVugcjaVB7Ua8rDAaA@mail.gmail.com>
Subject: Re: High level GATT based profiles development
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: Santiago Carot <sancane@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jul 6, 2011 at 8:44 AM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
>> So far we have been using separate directories for each profile, in a
>> structure like:
>>
>> <profile>/main.c (init/exit functions)
>> <profile>/manager.c (device driver registration)
>> <profile>/<role>.c (actual implementation of the profile role)
>>
>> For instance, for Proximity we have:
>
> Actually two profiles: Proximity and Find Me.

Correct. FindMe and Proximity are very related (Find Me also uses the
Immediate Alert Service), therefore they are integrated into the same
plugin.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
