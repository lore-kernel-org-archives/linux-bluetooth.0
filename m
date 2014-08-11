Return-Path: <cyrus@holtmann.org>
Message-ID: <1407764285.2710.4.camel@tkkaskin-mobl3.ger.corp.intel.com>
Subject: Re: Bug: bluetoothd dies when connecting device
From: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 11 Aug 2014 16:38:05 +0300
In-Reply-To: <CABBYNZK0NOKzBAeBAvp=FTA7ysk6yZm_kwUqDTdJmUhfsmJ-Tw@mail.gmail.com>
References: <53E8BCF6.6040502@linux.intel.com>
	 <CABBYNZK0NOKzBAeBAvp=FTA7ysk6yZm_kwUqDTdJmUhfsmJ-Tw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2014-08-11 at 16:12 +0300, Luiz Augusto von Dentz wrote:
> Hi Tanu,
> 
> On Mon, Aug 11, 2014 at 3:54 PM, Tanu Kaskinen
> <tanu.kaskinen@linux.intel.com> wrote:
> > Hi,
> >
> > I tried to work on the oFono HFP patches for PulseAudio, but I couldn't
> > really do anything, because BlueZ is basically not working at all on my
> > machine. When I try to connect my Nokia BH-505 headset, bluetoothd sort of
> > dies. The process doesn't terminate, but it disconnects from D-Bus.
> >
> > I'm on Fedora 20, PulseAudio and BlueZ are compiled from current git master.
> > oFono is not involved here in any way. I have attached an annotated log of
> > the headset connecting process, in case someone wants to investigate this.
> > The starting scenario in the log is that pulseaudio and bluetoothd are not
> > running, and I have previously removed the headset from the BlueZ database.
> > First I start pulseaudio with verbose logging and timestamps in the
> > background, then in the same terminal I start bluetoothd with -d -n options
> > in the background, and then still in the same terminal I start bluetoothctl
> > to issue the commands for connecting the headset, so pulseuadio, bluetoothd
> > and bluetoothctl output are all interleaved. Connecting the device appears
> > to work at first, but when PulseAudio tries to start streaming to the
> > headset, things fall apart.
> 
> It is very likely a problem with SELinux (either set it to disabled or
> permissive should make it work) blocking fd passing and making us
> disconnect,

Thanks for the tip, disabling SELinux seemed to do at least something. I
can't test the use case, because now pulseaudio complains that
"properties changed in unknown adapter", i.e. somehow pulseaudio doesn't
find /org/bluez/hci0 during initialization and then is very confused
when changes happen in that adapter. I'll have to debug this later.

-- 
Tanu

