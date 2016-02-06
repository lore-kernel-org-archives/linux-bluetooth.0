Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Sat, 6 Feb 2016 22:34:56 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Barry Byford <31baz66@gmail.com>,
	Bluez mailing list <linux-bluetooth@vger.kernel.org>
Subject: Re: Scanning for beacons
Message-ID: <20160206203456.GA17218@t440s.P-661HNU-F1>
References: <CAAu3APZmyN1khWMBFbiavx1Rb7GR8o9KEeLQgJCimwQAc6Um2A@mail.gmail.com>
 <20160206202029.GA14700@t440s.P-661HNU-F1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160206202029.GA14700@t440s.P-661HNU-F1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sat, Feb 06, 2016, Johan Hedberg wrote:
> On Sat, Feb 06, 2016, Barry Byford wrote:
> > I'm still having problems with getting information from beacons using
> > the DBus API. Using the DBus API is generally working well. But if
> > there are devices that are advertising in 'broadcast' mode then I
> > can't seem to get the service data being broadcast by the beacon.
> > 
> > Following on from discussions had before
> > (http://thread.gmane.org/gmane.linux.bluez.kernel/65201/focus=65263)
> > I've experimented with Bluez 5.36 and 5.37.
> > I've compiled the above versions with --enable-experimental  and
> > --enable-maintainer-mode and have the bluetoothd running with -E
> > 
> > Linux kernel:
> > $ uname -a
> > Linux raspberrypi 4.1.13+ #826 PREEMPT Fri Nov 13 20:13:22 GMT 2015
> > armv6l GNU/Linux
> > 
> > I have various beacons around and also have got another Raspberry Pi
> > broadcasting an Eddystone URL using the Bluez DBus API. All of these
> > beacons can be seen fine by various apps on my phone.
> > The code for the advertiser using DBus API can be found at:
> > https://github.com/ukBaz/python-bluezero/blob/master/examples/eddystone-url-beacon.py
> > which can be run with:
> > python eddystone-url-beacon.py http://www.bluez.org/
> > 
> > To do the scanning for the beacons I'm using either bluetoothctl or
> > using the test/test-discovery script in the Bluez download.
> > 
> > Any help or suggestions as to what I'm doing wrong would be appreciated.
> 
> According to doc/device-api.txt the corresponding device objects should
> exhibit a ServiceData property on their Device1 interface. Greping for
> "ServiceData" in the sources seems to indicate that at least the "info"
> command in bluetoothctl should be able to show this.

Or is the problem that device objects do not get created at all for the
broadcasting devices? Right now bluetoothd requires the advertising data
to have the discoverable flag set in order for new device objects to be
created. It also looks like the Advertising D-Bus interface doesn't add
that to the advertising data unless the "peripheral" type is used. This
doesn't seem right to me since "broadcaster" should also be allowed to
set the flag (imo). So some change to the Advertising D-Bus API might be
needed. There's a lot of speculation in the above though, so it'd be
good if you could confirm if any of it is correct.

Johan
