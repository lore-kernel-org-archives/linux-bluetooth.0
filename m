Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1295654876.1774.24.camel@ubuntuLab1>
References: <1295654876.1774.24.camel@ubuntuLab1>
Date: Sat, 22 Jan 2011 15:21:15 +0800
Message-ID: <AANLkTi=gLKMvWuUeyjqGBQuWd5ztjjr10d44H4A1fFfZ@mail.gmail.com>
Subject: Re: Attribute Server and Client TODOs
From: Erin Yueh <erinyueh@gmail.com>
To: Brian Gix <bgix@codeaurora.org>
Cc: claudio.takahasi@openbossa.org, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On Sat, Jan 22, 2011 at 08:07, Brian Gix <bgix@codeaurora.org> wrote:
> Hi Claudio, etc,
>
> Sorry for the repeat --> I sent it to the incorrect list the first time.
>
> We are starting to look at the adopted LE profiles, and it is becoming
> clear that Higher layer (Applications etc) server support will be needed
> for some of the significant use cases such as Proximity.  Is anybody
> currently working on a D-Bus interface to the Attribute Server?  I know
> there is nothing in code that has been up-streamed yet, but I was
> wondering if anyone has put some thought into what a D-Bus interface for
> the Attribute Server might look like?
>
yup, I was studying how to use LE in bluez recently. I can run Attribute server/
client on two Ubuntu machines. Then, I use gatttool to verify the primary and
characteristics data. I wrote my notes in my blog. If you have interests, you
could read for reference.
http://i-miss-erin.blogspot.com/2010/12/gatt-related-dbus-api.html

> Also, one of my compatriots is telling me that she cannot get the GATT
> Client D-Bus interface to work.  I don't know if this is a simple lack
> of Introspection Data (required by d-feet), or if there is a build or
> configuration parameter that needs to be setup.  I have just been using
> the gatttool to run my tests, and not going through D-Bus.  If anybody
> has been using D-Bus for GATT Client testing, I would be interested in
> finding out if there is some setup requirements that I am missing.
>
I only modified EnableLE and AttributeServer two values in main.conf and
add --enable-attribute on building bluez. Then, it can work. I can use dbus-send
to query data. I also wrote the notes about setting up gatttool in bluez over
BR/EDR.
http://i-miss-erin.blogspot.com/2010/12/gatttool-in-bluez-over-bredr.html

> Thanks for your time.
>
>
> --
> Brian Gix
> bgix@codeaurora.org
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Thanks,
Erin Yueh
