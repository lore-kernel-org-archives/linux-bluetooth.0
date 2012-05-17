Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAOnmHE9P-PUQOLh_skQxBXZx53fBe9u4jHu8HoDTwZEVOd4xAg@mail.gmail.com>
References: <1322850850-18019-1-git-send-email-anderson.lizardo@openbossa.org>
	<CA+XVXffynitA+JYzRnqiRJPQyyrTh+HMNUWQgb0LzD4iowoxpg@mail.gmail.com>
	<CAJdJm_MXwG0vicPL1zPDBYKj-GXRgacvyg9wqpe5OAhey5q4VA@mail.gmail.com>
	<CAOnmHE9P-PUQOLh_skQxBXZx53fBe9u4jHu8HoDTwZEVOd4xAg@mail.gmail.com>
Date: Thu, 17 May 2012 10:50:41 -0400
Message-ID: <CAJdJm_O9dhJg3BZZjiTH+6a0VrryXEnxUZf670jPCJUAZ-=0sw@mail.gmail.com>
Subject: Re: [PATCH RFC BlueZ 0/5] Time Profile (server) improvements
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: "Arun K. Singh" <arunkat@gmail.com>
Cc: Arik Nemtsov <arik@wizery.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arun,

On Wed, May 16, 2012 at 7:40 AM, Arun K. Singh <arunkat@gmail.com> wrote:
> Hi Anderson,
>
> On Thu, Feb 2, 2012 at 4:42 AM, Anderson Lizardo
> <anderson.lizardo@openbossa.org> wrote:
>
> <snip>
> ..
>
>> But even with the initial implementation, most Time clients will be
>> supported just fine. They will just not be able to update the phone's
>> own time or be notified of manual changes to the phone time (this will
>> be supported with the D-Bus API).
>
> Unless I missed such discussions on Time client support, could you
> comment on plans to support it. From what I figure is a time client
> will need to configure few things on the server such as notifying on
> time udpates/reference time etc. which may need dedicated API's. Do
> you have plans to support time client API's as well?

The current code (and the relevant discussion) is only related to Time
Server D-BUS API. It is needed so the platform specific stuff (e.g.
system clock update) can be done outside of BlueZ, by a Time "agent".

If you are interested on implementing Time Client support, you will
need to propose a separate API. I am not aware of anyone working on
client side support.

>
> Thanks,
> Arun

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
