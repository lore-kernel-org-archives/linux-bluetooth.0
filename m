Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <7.0.1.0.2.20110622230344.031f5790@gmx.net>
References: <7.0.1.0.2.20110622230344.031f5790@gmx.net>
Date: Thu, 23 Jun 2011 09:49:50 +0300
Message-ID: <BANLkTikuRgeFW-fXckR4ST14idxPSmNP7g@mail.gmail.com>
Subject: Re: Media API with more than one headset
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Peter Kornatowski <pkorn@gmx.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Thu, Jun 23, 2011 at 12:23 AM, Peter Kornatowski <pkorn@gmx.net> wrote:
> Hi,
>
> I'm using the new bluez media api to set bluetooth headsets into playing
> mode and get the fd's of the corresponding sockets with a program written in
> C. This works fine with just one headset, but I'm using up to three at the
> same time over three bluetooth adapters. So my program (bt-audio) creates a
> dbus-service with three paths (/test/endpoint0, ...1, ...2) and each path
> has an interface org.bluez.MediaEndpoint with the four needed methods
> (SetConfiguration etc.). Then it scans for turned on headsets and calls
> RegisterEndpoint on the appropriate adapter-path. Then bluez calls three
> times SetConfiguration on my service. So basically like in the
> python-example "simple-endpoint". After that my app calls three times
> Acquire with "rw" on each of the given transport-paths to receive the
> socket-fd's.
> As I said, this works well and I can play and record some raw-files with
> very good quality. But when one of the headsets is turned off, the other two
> are put out of playing-mode. When I retry to put them back in playing-mode
> by calling UnregisterEndpoint and then RegisterEndpoint again, I just get
> "GDBus.Error:org.bluez.Error.NotAuthorized: Operation Not Authorized" and
> see "sco_bind: Address already in use" in syslog. When retrying too often,
> bluetoothd segfaults (but this may be related to the way i tried some
> recovery of this problem in my code) with:
> kernel: [34309.873606] bluetoothd[29235]: segfault at 6e652f74 ip b76b9b20
> sp bf93c430 error 4 in bluetoothd[b768c000+7e000]
>
> Only after restarting my program (and thus re-registering my dbus-service),
> I am able to put the headsets back in playing mode again.
>
> I also tried this use-case with your simple-endpoint python-script by
> modifying it like this:
>
> def acquire_cb(fd, imtu, omtu):
>        print "Acquire successfull! New fd: %s with iMTU %i and oMTU %i" %
> (fd, imtu, omtu)
> def acquire_error(error):
>        print "Acquire failed: %s" % (error)
>        mainloop.quit()
>
> ...
>
> @dbus.service.method("org.bluez.MediaEndpoint", in_signature="oay",
> out_signature="")
> def SetConfiguration(self, transport, config):
>        print "SetConfiguration (%s, %s)" % (transport, config)
>        media_transport = dbus.Interface(bus.get_object("org.bluez",
> transport), "org.bluez.MediaTransport")
>        media_transport.Acquire("rw", reply_handler=acquire_cb,
> error_handler=acquire_error)
>        return
>
> So even after starting two or three processes of this script (each with a
> different hciX), I get the same behaviour: putting all headsets in playing
> mode is no problem, but turning off one headset puts the others out of
> playing mode. Trying to put them back in playing mode requires a restart of
> the scripts, otherwise I just get the same error: "Acquire failed:
> org.bluez.Error.NotAuthorized: Operation Not Authorized".
>
> So why are the other headsets always put out of playing mode and why can't
> you put them back in playing mode again? Looks like a bug to me, hopefully
> someone of you can help. I attached the syslog cutout of this problem, too
> (first section is with my C-program, second with the python-script).

Interesting, this could be a bug in SCO socket can you try that with
a2dp too? In the meantime I gonna try to reproduce it myself, btw what
kernel are you using?

-- 
Luiz Augusto von Dentz
