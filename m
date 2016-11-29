Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1480454922.19570.9.camel@deako.com>
Subject: Re: d-bus or management api for beacon stuff
From: Brennan Ashton <brn@deako.com>
To: Don Zickus <dzickus@redhat.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Barry Byford <31baz66@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Tue, 29 Nov 2016 13:28:42 -0800
In-Reply-To: <20161129210137.GX35881@redhat.com>
References: <20161123214013.GZ35881@redhat.com>
         <CABBYNZKYf3b8zTzGFNqd_3LGxYZkgo_g4LRs=jf=_qYS3fj1vA@mail.gmail.com>
         <20161128205526.GP35881@redhat.com>
         <CAAu3APY8oK4O57fbwzULRHiMnVT+75KQEbOaAEQRp-W6rJaWHw@mail.gmail.com>
         <CABBYNZ+7n3HR50ENp-Zjjb0uUM=YPPpP5ndRA38w9+gqXROFRw@mail.gmail.com>
         <1480449363.19570.6.camel@deako.com> <20161129210137.GX35881@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2016-11-29 at 16:01 -0500, Don Zickus wrote:
> On Tue, Nov 29, 2016 at 11:56:03AM -0800, Brennan Ashton wrote:
> > 
> > > 
> > > > 
> > > > SetDiscoveryFilter might also be necessary/helpful.
> > > 
> > > Yep, the SetDiscoveryFilter might be the way to go, the only
> > > missing
> > > part that it doesn't do right now is to disable duplicate
> > > filtering,
> > > but we might need some flag with a big warning that this will
> > > spam
> > > the
> > > bus like crazy or perhaps it can only be used along RSSI
> > > filtering,
> > > which is to prevent people to use advertisement/scanning APIs as
> > > a
> > > transport over D-Bus.
> > > 
> > > We could offer a file descriptor based solution for transport
> > > emulation using scanning/advertising to prevent spamming D-Bus
> > > but
> > > that has to play nicely with other application, either that or we
> > > only
> > > allow this over MGMT interface which is what we suggest in case
> > > there
> > > is no other use for Bluetooth in the system.
> > > 
> > > And btw, I wouldn't account Android and other mobile OSes
> > > allowing
> > > such raw access for much longer, it takes way too much power and
> > > can
> > > probably block any other Bluetooth peripheral to work, so it is
> > > probably only good to write packet sniffer and other debug tools
> > > on
> > > top of the system but it really offer nothing to the regular
> > > user.
> > 
> > I have had to resort to using the HCI interface to work with
> > scanning
> > and advertising beacon packets.  I had mentioned in an earlier
> > thread
> > the issue with duplicates.  Not only do you end up with a lot of
> > spam
> > on the dbus interface you end up with an ever increasing number of
> > bluetooth devices.  The Bluetooth mesh uses this transport, so I
> > really
> > would like to see a nice interface to support rx/tx of these
> > packets.
> 
> Hi,
> 
> Sorry for being ignorant (as I can't quite find the filter duplicate
> code
> other than the setting of the bit), but would throttling work
> here?  Cap the
> duplicates at say every 100ms or 10x/second.  That probably won't
> help with
> power consumption (unless start/stop of the radio is quick?).
> 
> Just trying to help move this along..  willing to code/test.
> 
> Cheers,
> Don
> 
The thread I mentioned is here:
https://marc.info/?t=147345134200002&r=1&w=2

The constant of interest is this LE_SCAN_FILTER_DUP_ENABLE.  I had to
recompile with this disabled because I never wanted the filter for my
application.  I had proposed making this an option in the adaptor
interface, but there did not seem to be any interest.

--Brennan

