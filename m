Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Nicholas A. Preyss" <nalp@gmx.net>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] questions about BT audio headset support...
Message-ID: <20040507113025.GA23044@gmx.net>
References: <409AD45D.6080102@dark-reality.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <409AD45D.6080102@dark-reality.de>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 7 May 2004 13:30:25 +0200

On  0, Lars Grunewaldt <lgw@dark-reality.de> wrote:
> I decided to invest some of my precious time into improving audio
> support for BT headsets; I'm going to take over maintenance of the
> snd-bt-sco project.

This is fine. 

> Right now, the way it works is this:
> there's a user space program that handles the rfcomm and sco connection
> (my enhanced version listens on open rfcomm for a connection request by
> the headset, and opens the sco channel on demand), and an alsa audio
> device driver. The device driver polls audio data to and from the
> headset; the connection is managed by the user-space program.
>
> Of course this is possibly not the best way of implementing things, but
> I'm a bit stuck here.

There are several threads in the mailing list archive about how sco-alsa
support should be implemented.

> The nicest way of implementing a better audio support would be having a
> daemon that
> a) listens for an incoming rfcomm connection that is open by the headset
> itself
> b) waits for a connection attempt (say, alsa audio interface opened) and
> initiate such a connection
> c) has the (optional) possibilty of keeping an open rfcomm session.
> Reason for this one is the not-so-short rfcomm handshake time. The
> rfcomm channel does not drain to much power from the headset, so it
> might be a good idea to keep a steady connection at least as an option.

I think the hs profile states that the rfcomm connection should stay up
when the devices support park mode, otherwise rfcomm connection may be 
closed too when sco channel is closed. So i think the user-space daemon
should support both modes. 
I don't know how park mode is implented in bluez and whether rfcomm
connections survive parking&unparking cleanly.

> I don't have any clues how to implement this; what do you experts mean?
> Should I try to enhance sco support itself, or should this stuff
> (connection handling) be done in user-space? What is the easiest way to
> recognize incoming rfcomm connections (listener on hci devices or
> something?)

In my opinion, the whole connection handling should be done in
user-space. In kernel-space only a generic "sco channel" - "alsa device" 
binding interface should stay. 

nicholas


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
