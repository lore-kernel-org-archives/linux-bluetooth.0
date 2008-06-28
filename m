Return-Path: <cyrus@holtmann.org>
Message-ID: <02c901c8d8be$25698f80$6701a8c0@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
References: <028701c8d897$74b68880$6701a8c0@freqonedev>
	<4C97DD70-6B7E-43A0-8BB0-A1F4328EAEA4@gmail.com>
Date: Fri, 27 Jun 2008 20:27:34 -0500
MIME-Version: 1.0
Subject: Re: [Bluez-devel] Connecting to audio_service.Control (or
	otherinterfaces)
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

Thanks...I missed seeing the new doc/audio-api.txt

It appears to be the old Headset and Sink, with new object path.  That said, the mechanics (esp. SDP browse and pairing) appear to 
be more integrated and I will be trying these out ASAP.

DS
----- Original Message ----- 
From: "Johan Hedberg" <johan.hedberg@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Sent: Friday, June 27, 2008 4:18 PM
Subject: Re: [Bluez-devel] Connecting to audio_service.Control (or otherinterfaces)


Hi David,

On Jun 27, 2008, at 23:50, David Stockwell wrote:
> That said: is it still your intent (or that of the development
> group) that the Object Path for audio-connected devices will be /org/
> bluez/audio/device<n> (where "n" is 0-based)?

In 4.0 with hcid and the plugins there is only one object path
hierarchy and a single object path per remote device (created by
CreateDevice or CreatePairedDevice). These paths have some generic
name plus the remote address and I don't remember right now how it
looks like. Try out those Create*Device methods and find out :)

> I assume that one would have to do any/all pairing against the
> org.bluez.Adapter object (e.g., object path /hci0), creating a
> Device object (e.g., /hci0/dev_00_02_5B_01_A4_74) before connecting
> to the audio Service and creating the audio Device (using the BT
> Address of the remote device, e.g., 00:02:5B:01:A4:74).  Do I have
> this right?

No. In 4.x only one method call is needed to set up a new device.
Calling CreateDevice or CreatePairedDevice will cause hcid to perform
SDP discovery and if it finds audio profiles a callback will be fired
into the audio plugin which in turn will register the necessary audio
specific D-Bus interfaces for the new device object.

> How much of what is in audio-api.txt is or will be obsolete under 4.x?

Any API docs outside of the doc/ subdirectory are obsolete. You can
find the 4.x audio API in doc/audio-api.txt

Johan





-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
