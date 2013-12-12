Return-Path: <cyrus@holtmann.org>
Message-ID: <1386808303.1982.36.camel@nuvo>
Subject: Re: openSUSE 13.1:  bt headsets lose connection
From: Bastien Nocera <hadess@hadess.net>
To: colbec@start.ca
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Thu, 12 Dec 2013 01:31:43 +0100
In-Reply-To: <1385236029.2236.7.camel@linux-3kti>
References: <1385236029.2236.7.camel@linux-3kti>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, 2013-11-23 at 14:47 -0500, Colin Beckingham wrote:
> In openSUSE 12.3 bluetooth operations were mostly ok. In the last few
> days I have upgraded from 12.3 to 13.1 and now none of my bt headsets
> can remain connected. Pairing is not a problem, but then they
> immediately disconnect.
> 
> I have posted a bug at gnome-bluetooth, but it seems that a previous
> similar bug has been tested and found that gnome-bluetooth may be
> excluded. Here is the bug report:
> 
> https://bugzilla.gnome.org/show_bug.cgi?id=712379
> 
> I have run a test connection using bluetoothd (5.11) in debug mode, and
> have attached the output in file bluedump.txt.
> 
> Also I have tried running bluetoothd with the -E option and no change.
> 
> I understand that it is possible this may already be known, and that
> pulseaudio may be involved. But since I have the debug output I thought
> I would check with the linux-bluetooth community first.

If your headset only has support for HFP/Hansfree, it likely won't work
with PulseAudio yet/anymore. PulseAudio is currently adding support for
this.

Cheers

