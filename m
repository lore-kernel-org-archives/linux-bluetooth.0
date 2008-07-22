Return-Path: <cyrus@holtmann.org>
Message-Id: <B6E47BE2-D488-41E1-A4DF-12D1B9E108A0@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <001f01c8eb58$d65ede10$6701a8c0@freqonedev>
Mime-Version: 1.0 (Apple Message framework v926)
Date: Tue, 22 Jul 2008 16:41:44 +0300
References: <001f01c8eb58$d65ede10$6701a8c0@freqonedev>
Subject: Re: [Bluez-devel] Quick question about org.bluez.Device and
	.audio.* Properties
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

On Jul 21, 2008, at 20:40, David Stockwell wrote:
> In the near-future 4.x, I understand that the org.bluez.audio.*
> interfaces will be attached to the existing Device, such that the  
> object
> path (e.g.) /hci0/dev_* will have/export multiple DBus interfaces, not
> only org.bluez.Device but also org.bluez.audio.Control (could be
> multiple interfaces of the org.bluez.audio family).  I also understand
> that the org.bluez.audio.* interfaces will be set up based on the SDP
> records in the host and remote when the connection/pairing is  
> completed.
>
> Is my understanding of this accurate?

Yes.

> Second question: org.bluez.Device has a number of properties (e.g.,
> Connected) which are also valuable in the context of  
> org.bluez.audio.*;
> should we duplicate the appropriate properties (and code) into the
> audio.* interface as well, or just require that anyone using wishing  
> to
> access these properties address org.bluez.Device?  Similarly, when a
> property changes, would we want to send the signal to a callback
> listening to .Device and .audio.*, or only to .Device?

The org.bluez.Device property relates only to the low-level ACL status  
and not to any higher level connections. The audio service would have  
it's own signals it sends based on the state of its L2CAP or RFCOMM  
sockets or even higher level protocol states on top of the sockets.

Johan

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
