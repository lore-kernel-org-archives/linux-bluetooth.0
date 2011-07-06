Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAKT1EBcaK2KkpSs=jznV1e8UbGA9bv3nWyx79d1c=YOxbr25dA@mail.gmail.com>
References: <CACLukzJSY0dXp8Ns5bRARN6OwWUh+_474NS5jEQ4mD-85Nxh0w@mail.gmail.com>
	<CAJdJm_PaGa7Q-nmHx341FT8Qr-KzV1197Vc383P4tsdmHg8BKg@mail.gmail.com>
	<CAKT1EBcaK2KkpSs=jznV1e8UbGA9bv3nWyx79d1c=YOxbr25dA@mail.gmail.com>
Date: Wed, 6 Jul 2011 15:01:33 +0200
Message-ID: <CACLukzJf8gqejE0tBw6BMGXyOdfTU5YKw0GJC9=yETq4A==0_A@mail.gmail.com>
Subject: Re: High level GATT based profiles development
From: Santiago Carot <sancane@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

2011/7/6 Claudio Takahasi <claudio.takahasi@openbossa.org>:
> Hi Santiago,
>
> On Wed, Jul 6, 2011 at 8:05 AM, Anderson Lizardo
> <anderson.lizardo@openbossa.org> wrote:
>> Hi Santiago,
>>
>> On Wed, Jul 6, 2011 at 5:17 AM, Santiago Carot <sancane@gmail.com> wrote:
>>> Hello,
>>>
>>> I'd like to start coding a plugin for the Health Thermmeter Profile
>>> (TFP) but I have some doubts about where I should put the source code.
>>> I was thinking in to place the TFP plugin into the health folder but I
>>> don't know if you are planning to gather all High level GATT based
>>> plugins in the same directory or anything else.
>
> IMO it could be added in the health folder. Maybe GATT and non GATT
> health profiles will share some functions.
>

As far as I know there is nothing in common. I've got the idea idea of
​​putting in the same folder just to gather health purpose profiles in
the same place.

On the other hand, I thought that may be interesting to keep all GATT
profiles in the same place too.

>>>
>>> Any suggestion?
>>
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
>

I like the idea of creating a directory for the plugin too but I want
to be sure that all of us are following the same criteria before to
start to code.

Regards.
