Return-Path: <Steven.Singer@csr.com>
Message-ID: <41890BFF.8040501@csr.com>
Date: Wed, 03 Nov 2004 16:49:03 +0000
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: Stephen Crane <steve.crane@rococosoft.com>
CC: Marcel Holtmann <marcel@holtmann.org>,
   BlueZ Mailing List
    <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] RFCOMM service level security testing
References: <1099151759.16247.18.camel@pegasus>
    <1099433039.7125.13.camel@pegasus>
    <1099495689.3265.44.camel@baroque.rococosoft.com>
    <1099496238.6330.2.camel@notepaq>
    <1099497364.3261.64.camel@baroque.rococosoft.com>
In-Reply-To: <1099497364.3261.64.camel@baroque.rococosoft.com>
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

Stephen Crane wrote:
> On Wed, 2004-11-03 at 15:37, Marcel Holtmann wrote:
>> Another question is what should we do when the encryption on a link with
>> RFCOMM_ENCRYPT is switched off? At the moment L2CAP keeps works, but in
>> the RFCOMM layer I drop the connection by sending DM.
>
> Yeah I thought I saw something like this happen. I don't think it is
> correct behaviour. My reasoning would go something like this:
>
> * If encryption on a link is switched off at the HCI level, _all_ of the
> connections (L2CAP and RFComm) which required it should be closed
> shouldn't they?

Fair enough.

> * Conversely, encryption should be automatically turned off on a link
> when the last connection which required encryption is closed.

I don't see any strong reason for this. Encryption is free, once it's
on there's no advantage in switching it off (unless you want to run
an air sniffer, in which case you can turn it off at HCI).

> * Owners of a connection should be able to indicate that they're no
> longer interested in encryption by an ioctl on the L2CAP or RFComm
> socket.
>
> * Connections which were created without the encryption requirement
> should be able to ask for it by a similar ioctl.

This runs counter to the Bluetooth security model. Either a service
allows only trusted devices to connect or it allows any device. Are
there any situations where allowing untrusted devices to connect and
then become trusted later is superior to having two separate services,
one secure and one insecure. For example, rather than having an OBEX
service that doesn't require trust to accept a v-card but will initiate
a security procedure when an application/octet-stream is sent, instead
have two OBEX services, one for untrusted devices to send v-cards and
one for trusted devices to send anything.

Also, asking for authentication during a service activity may confuse
other implementations. If a device is displaying an animation of a
transfer in progress, how will it handle suddenly having to display
a Bluetooth passphrase entry screen?

Applying security at the start of a service is less prone to error
than working out when, during a session, security needs to be enabled.

> I imagine this behaviour would be required only very rarely but it seems
> the most intuitive to me. What do you think?

Can I add to this discussion, that any non-encrypted link must not be
treated as trusted. As well as snooping, a sufficiently determined
attacker can hijack a non-encrypted link. If they wait for
authentication to complete then take over the link they will be able to
insert their own packets and inherit the link's trust. Using encryption
also prevents man-in-the-middle attacks where the attacker uses each
device as an oracle to calculate the correct response to the
authentication challenge. The encryption key is derived, in part, from
information generated whilst calculating the response but which isn't
transmitted over the air.

Encryption should be seen as an integral part of authentication.
Either a link is authenticated and encrypted or it's unauthenticated.

Giving services a fine degree of control over encryption settings
just leaves more possibilities for incorrect, and hence insecure,
implementations.

	- Steven


**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

This footnote also confirms that this email message has been swept by
MIMEsweeper for the presence of computer viruses.

www.mimesweeper.com
**********************************************************************
