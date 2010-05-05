Return-Path: <cyrus@holtmann.org>
Subject: Re: HDP proposed API
From: Santiago Carot-Nemesio <scarot@libresoft.es>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <p2h2d5a2c101005040750n6c5ea46dk4722b6ca3bea5543@mail.gmail.com>
References: <1272959741.2182.123.camel@mosquito>
	 <m2u2d5a2c101005040304ke238595n54b8584dd78b8f37@mail.gmail.com>
	 <201005041254.37990.jcaden@libresoft.es>
	 <p2h2d5a2c101005040750n6c5ea46dk4722b6ca3bea5543@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 05 May 2010 12:53:42 +0200
Message-ID: <1273056822.2105.147.camel@mosquito>
Mime-Version: 1.0
To: unlisted-recipients:; (no To-header on input)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

El mar, 04-05-2010 a las 17:50 +0300, Luiz Augusto von Dentz escribió:
> Hi,
> 
> On Tue, May 4, 2010 at 1:54 PM, José Antonio Santos Cadenas
> <jcaden@libresoft.es> wrote:
> > Hi all,
> >
> > Next a simple example program in python using the api that we proposed in this thread.
> >
> > We still use the name Device but maybe a better name can be used.
> >
> > Regards.
> >
> > ----------
> > #!/usr/bin/python
> > # -*- coding: utf-8 -*-
> >
> > import dbus
> > import dbus.service
> > from dbus.mainloop.glib import DBusGMainLoop
> > import gobject
> > import os
> >
> > DBusGMainLoop(set_as_default=True)
> > loop = gobject.MainLoop()
> >
> > obj_path = "/python/tester/hdp"
> >
> > bus = dbus.SystemBus()
> >
> > # This object receives the information from the daemon
> > class HDP(dbus.service.Object):
> >        def __init__(self, bus, obj_path):
> >                self.bus = bus
> >                dbus.service.Object.__init__(self, self.bus, obj_path)
> >        @dbus.service.method('org.bluez.HdpAgent',
> >                             in_signature='o', out_signature='',
> >                             sender_keyword='sender')
> >        def DeviceConnected(self, path, sender=None):
> >                print "Connected new device %s: (sender %s)" % (path, sender)
> >        @dbus.service.method('org.bluez.HdpAgent',
> >                             in_signature='o', out_signature='',
> >                             sender_keyword='sender')
> >        def DeviceDisconnected(self, path, sender=None):
> >                print "Device %s: disconnected (sender: %s)" % (path, sender)
> >        @dbus.service.method('org.bluez.HdpAgent',
> >                             in_signature='oq', out_signature='',
> >                             sender_keyword='sender')
> >        def DeletedDc(self, dev, mdlid, sender=None):
> >                print "Data channel: %d deleted on dev %s (sender %s)" % \
> >                                                (mdlid, dev, sender)
> >        @dbus.service.method('org.bluez.HdpAgent',
> >                             in_signature='oqh', out_signature='',
> >                             sender_keyword='sender')
> >        def CreatedDc(self, dev, mdlid, fd, sender=None):
> >                print "Data channel: %d created on dev %s: fd: %d " % \
> >                                                (mdlid, dev, fd, sender)
> >
> > hdp_obj = HDP(bus, obj_path);
> >
> > manager = dbus.Interface(bus.get_object("org.bluez", "/"),
> >                                                "org.bluez.Manager")
> > hdp = dbus.Interface(bus.get_object("org.bluez", manager.DefaultAdapter()),
> >                                                "org.bluez.Hdp")
> >
> > data_spec = 1
> > session_path = hdp.CreateSession(obj_path, data_spec)
> >
> > session = dbus.Interface(bus.get_object("org.bluez", session_path),
> >                                                "org.bluez.HdpSession")
> >
> > # Configuration of the session, adding suported features
> > source_role = 0
> > mdep = session.AllocateMdep(source_role)
> > session.AddFeature(mdep, 4100, "Pulse oximeter")
> >
> > sink_role = 1 # Sink role
> > mdep2 = session.AllocateMdep(sink_role)
> > session.AddFeature(mdep2, 4111, "Scale")
> > session.AddFeature(mdep2, 4100, "Pulse oximeter sink")
> >
> > # Now start the session
> > # Starts a MCAP session and register in the SDP
> > session.Start()
> >
> > # *****************************************************************************
> > # Now, if you start the main loop, the HDP events will be notified in HDP class
> > # *****************************************************************************
> >
> > # Connect to a remote device
> > addr = "XX:XX:XX:XX:XX:XX"
> 
> Where do I get this address from, and more importantly how do the
> application associate that this device supports hdp? To me bdaddr is
> meaningless in the API, we have done this mistake before and we
> learned the hard way that the API should be convenient to use and
> bdaddr hardly is.
> 
> > dev_path = session.Connect(addr)
> > dev = dbus.Interface(bus.get_object("org.bluez", dev_path),
> >                                                "org.bluez.HDPDevice")
> >
> > dcid = dev.OpenDc(rem_mdep, conf)
> > fd = dev.GetDcFd(dcid)
> >
> > # You can use the fd for write or read data.
> > # If the read/write operation fails, reconnection will be performed getting
> > # the file descriptor again
> >
> > while some_condition:
> >        try:
> >                os.write(fd, "some_data")
> >        except:
> >                fd = dev.GetDcFd(dcid) # Implicit reconeciton of dc
> >
> > dev.DeleteDc(dcid) # Close data channel
> > dev.DeleteAllDc() # Close all data channels for this mcl (device+session)
> >
> > if power_save:
> >        session.Disconnect(dev_path, False)
> >        # Close the connection with the remote devide for power save,
> >        # Reconnections will be possible
> > else:
> >        session.Disconnect(dev_path, True)
> >        # Close the connection with the remote devide forever and clean state
> >        # Reconnections will NOT be possible
> 
> IMHO leaving the application to decide when to do save power is a bad idea.
> 
Sorry, may be that notation that we used in this example is not enough
clear. Please, let me explain you this matter.

The flag provided to disconnect an MCL indicates to MCAP layer if it
should or not save the state of the MCL, what are all negotiated data
channels and their configuration for possible future reconnections.

Please, note that a quick reconnection of data channels is an important
characteristic in MCAP, it will reduce the amount of data required to
take up again a previous connection.

In addition, bluetooth layer doesn't know when it should forget the
state of an MCL because iso/ieee11073-20601 layer is transport agnostic,
it means that only data exchange protocol layer knows when a
disconnection is permanent (not the transport layer).

Please, if you are thinking in alternatives to iso/ieee11073-20601 tell
us so that we can take into count those.

I don't know if you are familiarizated with the 11073-20601 protocol, in
any case I'm going to try to summarize the importance os this issue. The
iso/ieee11073-20601 defines a finite state machine that permits to an
aaplication layer to know when a disconnection is or not permanent. You
read the HDP white paper to see more examples of when a disconnection
should not be permanent to reduce the amount of
configuration-association data traffic exchanged between agents and
manager after a reconnection takes place. A quite of 11073-20601
knowledge may be required to understand the seriousness of this
situation. If you don't permit that applications can close an MCL saving
state for future reconnections, next time that some device connects
again with a manager they should exchange association traffic to restore
tha last state in wich agent and manager were last time that the device
was connected with the manager. Please don't hesitate to ask to me if
you have more doubts, I know that it may be difficult, but I only am
trying to expose the importance of this question, of course, if you have
a better solution it will be pleasure for me to listen it.

And consider again that we are always guiding our design decision by the
iso/ieee11073-20601 requeriments for what HDP was desgined. If you are
considering another platforms, tell us please: it will be easier to
agree on trade-offs.

To conclude, due to above feature, a manager could say to the transport
layer when a MCL should be stored or not in MCAP. If you don't do that,
MCAP wont be able to distinguish when a disconnection is temporal or
permanent and it will cache it for future reconnections. It may not be a
problem if memory resource is not a concern for you and if you are not
aware about that ;)

Sorry if I'm detailing too much but I think that it is an importan
design feature that we have to take into consideration before to fix the
definitiva HDP API. We wouldn't like that it may become an the Achilles'
hell of the entire protocol stack.

> > hdp.DeleteSession(session_path)
> > # Close the session, all connections and data channels will be closed
> >
> 
> Sorry but this is way too complicated for my taste, I guess the one
> shared by Elvis sometime ago has more potential because the device
> path design is reused, and so is the device driver code I suppose,
> which is much more convenient if we want to maintain this upstream.
> Instead of trying to figure out alone you 2 should be cooperating.
> 

Sorry, but IMHO I think that it isn't question of choosing one or the
other API. This shuldn't become a competition. I agree with you, I think
that we should work together to get the best HDP implementation for
Linux as soon as possible. Of course, we know you have a best knowledge
about how blueZ APIs should be and we are very glad to listen to you and
other members of the community.

We have experience with HDP/MCAP/ieee11073-20601 and we sould like to
share our knowledge with you to integrate it in blueA.

We are working in a new API which takes into count all comments received
by all of you. We will send to the list during the day so all you can
see it and comment it.

Please, let me know if you have some comments / questions.

Thanks for your time and your attention.

Best regards.

