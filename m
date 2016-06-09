Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160609203913.GI90326@redhat.com>
References: <20160609203913.GI90326@redhat.com>
From: Barry Byford <31baz66@gmail.com>
Date: Thu, 9 Jun 2016 21:50:16 +0100
Message-ID: <CAAu3APYx-XKGp-mnDG2M+vuHZYD5fBVz=5=Oa7mecSXucOnTsQ@mail.gmail.com>
Subject: Re: working bluetooth obex test scripts?
To: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Don,


On 9 June 2016 at 21:39, Don Zickus <dzickus@redhat.com> wrote:
> Hi,
>
> I was trying to put together some bluetooth obex test scripts to help
> continuously verify that interface works reliably on various machines we
> have.

I'm not sure I understand exactly what it is you are looking to do.

If you only want to check that you are submitting to DBus correctly
then you might want to take a look at the dbusmock library.

It only has limited support for Bluez currently but there are some
templates in there that are helpful. They have one for obex:
https://github.com/martinpitt/python-dbusmock/blob/master/dbusmock/templates/bluez5-obex.py

Regards,
Barry


>
> However, I am not very successful with the stuff in the test/ directory.
>
> I started by focusing on ftp-client -d <address> -l.  I assume I had to run
> the 'simple-obex-agent' on the machine with <address>.
>
> Working around the dbus.SessionBus errors (I am connecting through ssh
> instead of the desktop), I get 'Unable to find service record' after
> ftp-client creates a session.
>
> I think that is because it isn't connecting the remote agent correctly?
>
> Anyway, pointers for good scripts to run to test the obex interface?
>
> Cheers,
> Don
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
