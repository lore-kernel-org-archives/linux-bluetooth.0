Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <038c01c8d152$2d0fc1f0$6701a8c0@freqonedev>
References: <038c01c8d152$2d0fc1f0$6701a8c0@freqonedev>
Date: Wed, 18 Jun 2008 17:04:03 +0200
Message-Id: <1213801443.19872.6.camel@violet.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Next Release, and Device.DiscoverServices
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

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



-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
