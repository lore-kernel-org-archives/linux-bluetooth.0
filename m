Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CALJeEo7qPkUj-Wfea4Vme38=g97uWLL9BXP6igyM1RvQfHJYfg@mail.gmail.com>
References: <CALJeEo7qPkUj-Wfea4Vme38=g97uWLL9BXP6igyM1RvQfHJYfg@mail.gmail.com>
Date: Sat, 1 Jun 2013 11:41:58 +0200
Message-ID: <CANq1E4TVMgiU5odQDevn97ZMEm-ybpDop=JqvmGBg30QU0V82w@mail.gmail.com>
Subject: Re: Automatic pairing
From: David Herrmann <dh.herrmann@gmail.com>
To: Jonathan Nichols <jnichols@alumni.princeton.edu>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

On Wed, May 29, 2013 at 7:57 AM, Jonathan Nichols
<jnichols@alumni.princeton.edu> wrote:
> Hello,
>
>     I want to use bluez to set up a linux machine to automatically
> pair with devices that initiate pairings.  What is the recommended way
> of doing this?  I noticed that there is an autopair.c in bluez 5.5,
> but it isn't clear how to use it.  Is there any example code that
> shows how to use this file?
>
>     Any other suggestions for setting up a linux machine to
> automatically pair with any device that initiates a pairing?

Please have a look at the "simple-agent" tool in the bluez tree. The
bluez bluetoothd daemon allows dbus clients to provide "agents" which
are called for any incoming connection. This way you can either accept
or deny a new connection.
Agents are also asked for pin-input so you can always use your static
fixed PIN, if you want. This way, remote devices that don't know the
PIN will be automatically recjected.

Regards
David
