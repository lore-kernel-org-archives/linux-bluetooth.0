Return-Path: <cyrus@holtmann.org>
Message-ID: <04fa01c8d2f6$65597b50$6701a8c0@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Cc: "Marcel Holtmann" <marcel@holtmann.org>
References: <038c01c8d152$2d0fc1f0$6701a8c0@freqonedev> <1213801443.19872.6.camel@violet.holtmann.net>
Subject: Re: [Bluez-devel] Next Release, and Device.DiscoverServices
Date: Fri, 20 Jun 2008 11:55:05 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

Thanks for the feedback.  Upgrading to 3.33 resolved the immediate problem with accessing UUIDs, and I do get the correct UUID from 
the remote (hurray!).

FWIW, with SSP I intend to use only the "Just Works" model at this point, keeping the handshake as simple as possible (not a highly 
secure application).  So, the capability parameter will be "NoInputOutput", if I am reading the code correctly (adapter.c). 
Hopefully, that will "JustWork", and I can proceed with the effort I originally undertook.  At any rate, I will be watching CVS 
closely...

All the best, and good luck with that server.  It always seems that just when you think you can trust a system's to be reliable, 
that's when the hard drive crashes...

DS
----- Original Message ----- 
From: "Marcel Holtmann" <marcel@holtmann.org>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Sent: Wednesday, June 18, 2008 10:04 AM
Subject: Re: [Bluez-devel] Next Release, and Device.DiscoverServices


Hi David,

> I have been working with Adapter.CreateDevice, and have been
> frustrated by finding that the list of UUIDs returned by
> Device.GetProperties is always empty.  (Getting the connectivity right
> is a necessary precursor to implementation of AVRCP with Metadata.)

the CreateDevice needs some more magic in case the remote device has no
public browse group.

Currently we have in device.c the following struct:

static uint16_t uuid_list[] = {
        PUBLIC_BROWSE_GROUP,
        HID_SVCLASS_ID,
        GENERIC_AUDIO_SVCLASS_ID,
        ADVANCED_AUDIO_SVCLASS_ID,
        AV_REMOTE_SVCLASS_ID,
        0
};

So in case the public browse group fails, it will go through the list of
additional UUIDs and search for them. So your AVRCP case should be
handled.

> Looking at the CVS, I see all have been quite busy, including adding a
> new DiscoverServices method, which I presume will do the querying of
> the remote SDP and filling in the list of UUIDs.  Am I correct?

So DiscoverServices will update the UUID list of course, but normally
there should be no need to call it. CreateDevice needs to be fixed to do
the right job.

The DiscoverServices is mainly for applications that need access to the
full service record. Stuff like obex-data-server for example.

> I also see a lot of work around BT2.1 and SSP.

Yep. We are almost done with. However you will need kernel changes to
make this work.

> Given all of that, I am about to pull everything down from CVS, but am
> wondering if you are about to do another release (don't want to waste
> any effort if things are stabilizing enough to release again in a few
> days).

I wanna do the release actually today.

Regards

Marcel
