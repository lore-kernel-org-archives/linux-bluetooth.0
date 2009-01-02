Return-Path: <cyrus@holtmann.org>
Message-ID: <62091.209.216.239.242.1230871687.squirrel@webmail.ipns.com>
In-Reply-To: <60678.209.216.239.242.1230838200.squirrel@webmail.ipns.com>
References: <60678.209.216.239.242.1230838200.squirrel@webmail.ipns.com>
Date: Thu, 1 Jan 2009 21:48:07 -0700 (MST)
Subject: Re: How do I get headset button events without .btscorc?
From: "Dave Schile" <dave@schile.com>
To: "Dave Schile" <dave@schile.com>
Cc: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> I screwed up the posting of this and made it part of a totally unrelated
> thread.  So, Im posting it agin so that people might see it in proper
> order.  Sorry.  I'm new at mailing lists.
>
> I figured this one out all  on my own!  Here is a script in python that
> uses dbus to get the bluetooth headset button press.  I think it might be
> helpful to add this to the wiki.
>
> <pre>
>
> def handler(sender=None):
>         os.system ('/usr/bin/twinkle --cmd answerbye') # <- that's the
> part
> specific to twinkle
> import dbus, os,  gobject
> from dbus.mainloop.glib import DBusGMainLoop
> DBusGMainLoop(set_as_default=True)
> bus = dbus.SystemBus()
> bus.add_signal_receiver(handler, signal_name="AnswerRequested")
> loop = gobject.MainLoop()
> loop.run()
>
> </pre>
>
> Dave
>
> Original message:
>
> I have searched all over the place and can't figure out how to do this.  I
> have a bluetooth headset connected to twinkle softphone.  There are
> commands available to send to twinkle, but with the new bluez drivers
> (without btsco) I don't know how to get the button event.  Can anyone help
> me?
>
> Thanks,
> David
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



hello,

After further work on this, I find that it's not working exactly right. 
The python code above gets the signal correctly, but that doesn't help
when you are trying to answer a call.  Terminating a call works fine,
because you are connected, but when a call is ringing in, there is no
connection so the signal event never is called.  Anyone know of a way to
make this work?

Thank you,
Dave

