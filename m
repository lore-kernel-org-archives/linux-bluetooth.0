Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 28 Nov 2016 15:55:26 -0500
From: Don Zickus <dzickus@redhat.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: d-bus or management api for beacon stuff
Message-ID: <20161128205526.GP35881@redhat.com>
References: <20161123214013.GZ35881@redhat.com>
 <CABBYNZKYf3b8zTzGFNqd_3LGxYZkgo_g4LRs=jf=_qYS3fj1vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZKYf3b8zTzGFNqd_3LGxYZkgo_g4LRs=jf=_qYS3fj1vA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Nov 24, 2016 at 03:07:21PM +0200, Luiz Augusto von Dentz wrote:
> Hi Don,
> 
> On Wed, Nov 23, 2016 at 11:40 PM, Don Zickus <dzickus@redhat.com> wrote:
> > Hi,
> >
> > I was trying to write some code to continuously scan the bluetooth field
> > for bluetooth devices sending advertising packets (ie beacon-mode).
> 
> That is tricky, if you have anyone else trying to use the adapter in
> this situation it will probably be blocked, we may add support for
> setting intervals but that will probably be a best effort in case
> there is no connection or other usage of the adapter by the system.
> 
> > These devices would come and go so I wanted to avoid the cache.
> 
> Beacon are not normally not connectable, connections and continuous
> advertisement don't go well together so we will probably have to
> reduce the intervals in order to maintain any traffic on the
> connections.


Hi Luiz,

Thanks for the response.  I am wondering if I explained it wrong.  I wasn't
looking to do advertisements but instead scan for advertisements.  I also
don't plan to connect to any of the advertising device, just read the
advertised data.


> 
> > I noticed the D-Bus interface doesn't quite allow me to do this (as it
> > caches the devices and I can't monitor the RSSI field).  But I think the
> > bluetooth management interface does. Is that the correct approach?
> 
> Yep you could in theory use the MGMT interface and manually add you
> beacon management on top, but I guess you don't want applications to
> do that since it would require root permissions to connect to the
> management socket, so making bluetoothd, via kernel?, to adjust the
> intervals is probably a better idea in the long run. We would probably
> have to maintain the biggest advertising window possible, and the
> consider:
> 
> 1.  Is it connectable/there any advertising instance that is
> connectable? If yes, the it has to adjust the window to allow them
> (perhaps using the default connection parameters).
> 2.  In case of a connection is made the controller may not be able to
> advertise anymore, and in case it can still advertise we need to make
> sure it doesn't interrupt the connection (this is not very clear if
> the controller is suppose to manage this somehow).
> 3. Similar to the connection situation we may have application
> scanning, again there might be problems if the controller cannot scan
> while advertising we would probably have to stop advertising.

Hmm, as I said above, I am wondering if I explained it wrong.

I was wondering how much was already done because in reality, I was just
going to mimic what android does on the phones with apple ibeacons except my
machines stay put and the ibeacons travel.

Currently I was using 'hcitool lescan --duplicates' and 'hcidump' and trying
to script that.  But wanted to be smarter. :-)

Cheers,
Don
