Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] RFCOMM service level security testing
From: Marcel Holtmann <marcel@holtmann.org>
To: Steven Singer <steven.singer@csr.com>
Cc: Stephen Crane <steve.crane@rococosoft.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41890BFF.8040501@csr.com>
References: <1099151759.16247.18.camel@pegasus>
	 <1099433039.7125.13.camel@pegasus>
	 <1099495689.3265.44.camel@baroque.rococosoft.com>
	 <1099496238.6330.2.camel@notepaq>
	 <1099497364.3261.64.camel@baroque.rococosoft.com>
	 <41890BFF.8040501@csr.com>
Content-Type: text/plain
Message-Id: <1099504367.7125.131.camel@pegasus>
Mime-Version: 1.0
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
Date: Wed, 03 Nov 2004 18:52:47 +0100

Hi Steven,

> > * If encryption on a link is switched off at the HCI level, _all_ of the
> > connections (L2CAP and RFComm) which required it should be closed
> > shouldn't they?
> 
> Fair enough.

do you know any document that explicit requires it? Maybe SIM Access?

Basically I think it is a good idea and for the RFCOMM part I must check
if I have to send DISC or DM. The L2CAP part must be fixed, but the new
HCI callback stuff should make this very easy. However it needs more
core changes for a better integration.

> > * Conversely, encryption should be automatically turned off on a link
> > when the last connection which required encryption is closed.
> 
> I don't see any strong reason for this. Encryption is free, once it's
> on there's no advantage in switching it off (unless you want to run
> an air sniffer, in which case you can turn it off at HCI).

I heard rumors that encryption costs more CPU and so consumes more
power. Is this still true with modern chips or can we ignore this?

> > * Owners of a connection should be able to indicate that they're no
> > longer interested in encryption by an ioctl on the L2CAP or RFComm
> > socket.
> >
> > * Connections which were created without the encryption requirement
> > should be able to ask for it by a similar ioctl.
> 
> This runs counter to the Bluetooth security model. Either a service
> allows only trusted devices to connect or it allows any device. Are
> there any situations where allowing untrusted devices to connect and
> then become trusted later is superior to having two separate services,
> one secure and one insecure. For example, rather than having an OBEX
> service that doesn't require trust to accept a v-card but will initiate
> a security procedure when an application/octet-stream is sent, instead
> have two OBEX services, one for untrusted devices to send v-cards and
> one for trusted devices to send anything.
> 
> Also, asking for authentication during a service activity may confuse
> other implementations. If a device is displaying an animation of a
> transfer in progress, how will it handle suddenly having to display
> a Bluetooth passphrase entry screen?
> 
> Applying security at the start of a service is less prone to error
> than working out when, during a session, security needs to be enabled.

We really need to investigate this and see how devices react. I had some
problems with activating encryption on HID after I had established the
control and interrupts channels.

> > I imagine this behaviour would be required only very rarely but it seems
> > the most intuitive to me. What do you think?
> 
> Can I add to this discussion, that any non-encrypted link must not be
> treated as trusted. As well as snooping, a sufficiently determined
> attacker can hijack a non-encrypted link. If they wait for
> authentication to complete then take over the link they will be able to
> insert their own packets and inherit the link's trust. Using encryption
> also prevents man-in-the-middle attacks where the attacker uses each
> device as an oracle to calculate the correct response to the
> authentication challenge. The encryption key is derived, in part, from
> information generated whilst calculating the response but which isn't
> transmitted over the air.
> 
> Encryption should be seen as an integral part of authentication.
> Either a link is authenticated and encrypted or it's unauthenticated.
> 
> Giving services a fine degree of control over encryption settings
> just leaves more possibilities for incorrect, and hence insecure,
> implementations.

This is a good point, but I think I will explicit have this fine gain
control. However it is enough to set the *_ENCRYPT flag for example and
the authentication will be triggered always first.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
