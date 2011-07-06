Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_PaGa7Q-nmHx341FT8Qr-KzV1197Vc383P4tsdmHg8BKg@mail.gmail.com>
References: <CACLukzJSY0dXp8Ns5bRARN6OwWUh+_474NS5jEQ4mD-85Nxh0w@mail.gmail.com>
	<CAJdJm_PaGa7Q-nmHx341FT8Qr-KzV1197Vc383P4tsdmHg8BKg@mail.gmail.com>
Date: Wed, 6 Jul 2011 09:44:06 -0300
Message-ID: <CAKT1EBcaK2KkpSs=jznV1e8UbGA9bv3nWyx79d1c=YOxbr25dA@mail.gmail.com>
Subject: Re: High level GATT based profiles development
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Santiago Carot <sancane@gmail.com>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Wed, Jul 6, 2011 at 8:05 AM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Santiago,
>
> On Wed, Jul 6, 2011 at 5:17 AM, Santiago Carot <sancane@gmail.com> wrote:
>> Hello,
>>
>> I'd like to start coding a plugin for the Health Thermmeter Profile
>> (TFP) but I have some doubts about where I should put the source code.
>> I was thinking in to place the TFP plugin into the health folder but I
>> don't know if you are planning to gather all High level GATT based
>> plugins in the same directory or anything else.

IMO it could be added in the health folder. Maybe GATT and non GATT
health profiles will share some functions.

>>
>> Any suggestion?
>
> So far we have been using separate directories for each profile, in a
> structure like:
>
> <profile>/main.c (init/exit functions)
> <profile>/manager.c (device driver registration)
> <profile>/<role>.c (actual implementation of the profile role)
>
> For instance, for Proximity we have:

Actually two profiles: Proximity and Find Me.

Regards,
Claudio.
>
> proximity/main.c
> proximity/manager.c
> proximity/monitor.c
> proximity/reporter.c
>
> HTH,
> --
> Anderson Lizardo
> Instituto Nokia de Tecnologia - INdT
> Manaus - Brazil
