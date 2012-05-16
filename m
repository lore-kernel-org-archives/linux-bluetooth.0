Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_MXwG0vicPL1zPDBYKj-GXRgacvyg9wqpe5OAhey5q4VA@mail.gmail.com>
References: <1322850850-18019-1-git-send-email-anderson.lizardo@openbossa.org>
 <CA+XVXffynitA+JYzRnqiRJPQyyrTh+HMNUWQgb0LzD4iowoxpg@mail.gmail.com> <CAJdJm_MXwG0vicPL1zPDBYKj-GXRgacvyg9wqpe5OAhey5q4VA@mail.gmail.com>
From: "Arun K. Singh" <arunkat@gmail.com>
Date: Wed, 16 May 2012 17:10:44 +0530
Message-ID: <CAOnmHE9P-PUQOLh_skQxBXZx53fBe9u4jHu8HoDTwZEVOd4xAg@mail.gmail.com>
Subject: Re: [PATCH RFC BlueZ 0/5] Time Profile (server) improvements
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Arik Nemtsov <arik@wizery.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On Thu, Feb 2, 2012 at 4:42 AM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:

<snip>
..

> But even with the initial implementation, most Time clients will be
> supported just fine. They will just not be able to update the phone's
> own time or be notified of manual changes to the phone time (this will
> be supported with the D-Bus API).

Unless I missed such discussions on Time client support, could you
comment on plans to support it. From what I figure is a time client
will need to configure few things on the server such as notifying on
time udpates/reference time etc. which may need dedicated API's. Do
you have plans to support time client API's as well?

Thanks,
Arun
