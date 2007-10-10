Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <55848.195.56.160.65.1191989167.squirrel@www.k-i-s.net>
References: <55848.195.56.160.65.1191989167.squirrel@www.k-i-s.net>
Date: Wed, 10 Oct 2007 12:01:00 +0200
Message-Id: <1192010460.7645.5.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] HFP and A2DP profile implementation for bluez
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

Hi Balint,

> I am trying to implement a HFP and a A2DP profile on top of bluez. I did
> check out the bluez-utils/audio stuff, but I couldn't get it working, so I
> decided to write my own, and publish it for your review so that you can
> pull it into bluez if you like it.
> 
> My primary problem with the current bluez-utils/audio implementation
> (apart that it's not working for me) is that gstreamer, d-bus is
> integrated all over the place.

that is a problem. If the solution is not integrated with D-Bus and our
audio service, we basically have no real use for it.

And the latest audio service release supports A2DP and HSP pretty well.
We have started working on the HFP support and if you can make your
implementation integrate into the audio service, that would be really
great.

The GStreamer part is fully optional. You don't have to use it and
actually currently even GStreamer applications are using the ALSA sink.

> I would prefer to implement the HFP and A2DP profiles so that are stand
> alone, and they can be integrated with d-bus, hal and gstreamer through an
> API. This would allow us/me to use the profiles not only on a desktop PC
> but also in an embedded environment where d-bus or gstreamer is not an
> option.

We have the Nokia N800 and OpenMoko Neo1973 phone that are embedded
platform and they work pretty good with the audio service (A2DP + HSP).
So I don't see what is the advantage of your attempt.

> The HFP profile is ready, all 4 state machines (main hfp, service
> connection, incoming call, outgoing call) work properly and one can
> accept, reject and make calls both from the Device or from the PC. For HFP
> audio io I use ALSA.

Please post the source code for review. Otherwise I can say anything.

> However for the A2DP, I failed to get up the L2CAP Transport Layer so I
> cannot get any audio out of L2CAP socket. My setup is the following:
> 
> Device: a2dp capable phone (SonyEricsson W850i and an MDA with windows
> mobile)
> PC: usb bluetooth dongle with latest bluez stack running on the
> 2.6.20-2936.fc7xen kernel
> 
> I implemented the L2CAP signaling layer, and the Device hooks up nicely
> with the PC and starts streaming the audio data. I can see the audio data
> with hcidump:
> 
> > ACL data: handle 1 flags 0x02 dlen 665
> L2CAP(d): cid 0x0041 len 661 [psm 25]
> AVDTP(m): ver 2 cc 0 pt 1 seqn 726 time 9478796 ssrc 1
> 
> But I don't know how to extract this data through the L2CAP socket which I
> opened for signaling. Is there some socket option that I need to set up in
> order to get the audio data? Or do I need to set up an other socket once
> the AVDTP state machine enters into OPEN state?

The signal channel is one socket, the media channel is a different one.
Check the audio service. It is doing this properly.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
