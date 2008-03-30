Return-Path: <cyrus@holtmann.org>
Message-ID: <7c3475fe0803291753v54b5cab7y46ae7fa3a5a4fa81@mail.gmail.com>
Date: Sun, 30 Mar 2008 01:53:51 +0100
From: "Phillip Berndt" <phillip.berndt@googlemail.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <7c3475fe0803291751q5e831d44ra758cc42969cc65f@mail.gmail.com>
MIME-Version: 1.0
References: <7c3475fe0803291751q5e831d44ra758cc42969cc65f@mail.gmail.com>
Subject: [Bluez-users] Making the PC behave like a headset
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

I'm trying to make my PC behave like a bluetooth headset. I already read
through the HSP specification and some code implementing its headset
part.  (namely a bluetooth plugin for Asterisk and the
"ProjectBluezHandfree" [1]).

Here's what I did, in order:
 * Create a RFComm listener socket for the control connection
 * Register at local SDP server (according to the specs: L2CAP, RFCOMM,
  generic audio and headset profile, headset service class)
 * Create a SCO listener socket for the audio connection
  (SOCK_SEQPACKET & BTPROTO_SCO - bind, listen & accept like with other
  sockets)
 * A RFComm handler responds to incoming RINGs.

I also changed my dongle's (CSR chipset) service class to audio and told
my mobile to use the "headset".

The RFcomm part seems to work: The mobile connects to the PC on incoming
calls. The PC responds. The mobile accepts the call.

As far as I understand the specification, the mobile should establish a
SCO link to my PC at that point.  This, however, does not happen.

What do I do wrong?

Thanks in advance,
Phillip Berndt

Ps. I do not subscribe the ML, please cc to my address

[1]
http://wall4.soft.uni-linz.ac.at/_wiki/tiki-index.php?page=ProjectBluezHandsfree

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
