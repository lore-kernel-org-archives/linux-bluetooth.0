Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030306145316.02505748@mail1.qualcomm.com>
Date: Thu, 06 Mar 2003 15:02:26 -0800
To: Stephen Crane <steve.crane@rococosoft.com>, marcel@rvs.uni-bielefeld.de
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] New BlueZ Security Manager
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <1046871982.2860.1155.camel@baroque.rococosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 05:46 AM 3/5/2003, Stephen Crane wrote:
>Hi Marcel, Max,
>On Marcel's German slides (for which I've lost the link) I noticed a
>revamped security manager on the TODO list. However I don't ever
>remember seeing a discussion about it here on the list. I'd like to
>kick-start this discussion if possible.
Sure. 
The idea is to have a device database (names, PINs, keys, etc).
The database will be updated by hcid (or what ever new name will be) 
and user tools that can add/delete/display PIN code and stuff.

>The main thing wrong with hcid (in my opinion) is what the security
>white-paper (http://www.bluetooth.com/upload/24Security_Paper.PDF)
>defines as support for security mode 2. This is where the
>owning-application enforces the security requirements for a service.
>
>The difference between this and the current setup (security modes 1 and
>3 in the whitepaper's terminology) is (I think) that hcid enforces
>permissions at the ACL level whereas service-level security takes place
>/after/ the ACL link is already up. It should be possible to allow SDP
>searches for example, but deny access to services discovered through
>SDP.
HCID (or any other daemon) need not be involved here. And it is possible. 
Our L2CAP layer already support this. RFCOMM support is in my todo list.

>I don't think that the current kernel API is rich enough to permit this.
>It ought to be possible for a server listening on a socket to discover
>the BDADDR of the connecting peer and either accept() or reject access
>--- probably through an ioctl(). On the client-side, a special error
>return from (or argument to) connect() could indicate that a PIN was
>required to connect.
That's one way to do it. The other way (which is simpler) is for the server 
to tell the kernel that the socket requires secure connection before doing
accept. And that's how current L2CAP sockets work. 

Looks like it's time to start working on utils-3.x. Let's wrap up 
minor pending fixes for current utils and libs, release stable version
and start working on new stuff.

Max
