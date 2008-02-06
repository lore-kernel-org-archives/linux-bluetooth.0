Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5c1c70820802052329s7e1e0d62pa43aa5f94e578ed3@mail.gmail.com>
References: <5c1c70820802052329s7e1e0d62pa43aa5f94e578ed3@mail.gmail.com>
Date: Wed, 06 Feb 2008 10:21:26 +0100
Message-Id: <1202289686.15090.209.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] SDP limiting connections?
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

Hi Pooyan,

> I'm having a strange problem with a BlueZ application.
> 
> My application advertises a service via SDP (using dbus etc).
> Bluetooth clients scan the area for computers providing this service,
> and then connect via SPP to my application, and can then exchange
> data.  The connections are handled in the normal socket/bind/listen
> method, each connection forks a thread to handle that connection.
> (Using BTPROTO_RFCOMM on the socket)
> 
> This is working fine, but with one significant problem.  If we have no
> connections, clients can scan and connect without problems.  If there
> is one current connection, this is still the case.  But if there are
> two current connections, then no clients can see the service via SDP.
> If another machine tries to (eg) do "sdptool browse <bdaddr>", it gets
> a "server is down" message.
> 
> But if either of those two connections then are terminated, all is
> well once again.  It's as if SDP is refusing to talk to clients once
> there are two SPP connections, but is ok with one or zero connections.
>  (Doing "sdptool browse local" on the server itself still shows the
> service that is advertised, so it is still visible locally, but not
> remotely.)
> 
> I'm using BlueZ 3.25 on a gentoo system, I've had this problem also with 3.24.
> 
> I've tried starting hcid with the -d flag (for debug info), and I can
> see the SDP queries with no obvious problems there.  I've also tried
> doing "hcidump -X -V" whilst two clients are connected, and if a
> remote machine tries to do a "sdptool browse" against my application,
> there is no HCI data visible at all.  But if the system is in the
> "healthy" state (ie, less than two connections), this does show the
> expected HCI traffic.
> 
> (The 'backlog' value for listen() is set to 30, so I don't think
> that's the problem)
> 
> I've tried the same bluetooth adapters on windows, and they do work
> with up to seven SPP connections, but obviously with very different
> application software.  I've tried two different brands of adapters
> with the same result.
> 
> In short, it looks as if the BlueZ SDP server is not responding at all
> whilst my application has two current SPP connections.  I don't know
> if that's what's actually happening, but that's how the symptoms
> appear.

if you don't see anything in hcidump from the other devices, then it is
not a SDP servers problem. Would would see connection attempts.

My guess is that both connection are as slaves. Check with "hcitool con"
and in that case the chip is pretty much busy keeping up. So you need to
have them to role-switch (RFCOMM_LM_MASTER).

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
