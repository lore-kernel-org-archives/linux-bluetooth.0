Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <423B3042.8060809@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] sdptool segfaults
References: <42272E36.3070503@tomtom.com>
    <1109865262.6722.84.camel@baroque.rococosoft.com>
In-Reply-To: <1109865262.6722.84.camel@baroque.rococosoft.com>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 18 Mar 2005 19:47:14 +0000

Stephen Crane wrote:
> This looks to me like the Samsung is formatting the profile descriptor
> list incorrectly. I guess it should be a sequence of sequences of
> { UUID, version } whereas the Samsung just formats it as a sequence.

I've been looking at this. Whereas the BT 1.1 SDP specification (BT 1.1
core spec, part E, section 5.1.10, pages 371 to 372) says:

  The BluetoothProfileDescriptorList attribute consists of a data
  element sequence in which each element is a profile descriptor that
  contains information about a Bluetooth profile to which the service
  represented by this service record conforms. Each profile descriptor
  is a data element sequence whose first element is the UUID assigned to
  the profile and whose second element is a 16-bit profile version
  number.

The DUN profile spec (BT 1.1 profile spec, part K:7, section 5.3, table
5.1, page 244) says, for the attribute BluetoothProfileDescriptorList
that the attribute is mandatory and its value is:

  Item                     Definition Type   Value              Status Default
  Profile #0                          UUID   Dial-up Networking M
  Parameter for Profile #0 Version    UInt16 0x0100             O      0x100

Which marks the version parameter as optional and gives a default to
be used if it's omitted (which might suggest that omitting it is not
only allowed, but should be expected).

It looks like there's an inconsistency in the spec. A profile author
reading the profile spec may well conclude that the version is optional,
whereas someone reading the protocol spec may just as easily conclude
that it's mandatory for all profiles.

A casual reading might suggest that the core spec states that each
element of the attribute is a sequence with exactly two elements. In
fact, it never quite gets round to stating the length of each
sub-sequence, just the meaning of the first two elements (however, this
does imply that it's mandatory to have at least two elements). It may be
worth making sure that BlueZ is future proof against the addition of any
further elements to each sub-sequence (though I suspect that, in
practice, this extension would never be used as it would break too many
current SDP client implementations).

Looking at the other profiles in the BT 1.1 core spec, the version is
optional for CTP, DUN and Fax and mandatory for Intercom and Headset.
For the LAN access, object push, FTP and Synchronization profiles, the
version number isn't separately marked as mandatory or optional, but
the whole attribute is optional. It looks like all new profiles are
marking the version as mandatory.

What's clear is that if you are including the version number, then the
correct format for the attribute is:

   SEQ{ ..., SEQ{ UUID, UINT16 }, ... }

what's less clear is what the correct format is if you choose to omit
the optional version. Should it be:

   SEQ{ ..., SEQ{ UUID }, ... }

or simply:

   SEQ{ ..., UUID, ... }

An analogy with the attribute ProtocolDescriptorList suggests the
former, but it's probably prudent for BlueZ to cope with both.

As a historical note, the profile version number was added between
version 0.9 (10 May 1999) and the first draft of version 1.0 (5 Jul
1999) of the BT spec. At the same time, the attribute's name was changed
from BluetoothProfileList to BluetoothProfileDescriptorList. Version 0.9
said in part E, section 5.1.10, page 323:

  The BluetoothProfileList attribute consists of a data element sequence
  in which each element is a UUID that represents a Bluetooth profile to
  which the service represented by this service record conforms.

No products should ever have been released based on the 0.9 spec, and
certainly nowadays no one is coding to that spec, but it's possible that
the optional status of the profile version, and hence the inconsistency
between the core and profile specs, dates back this far.

Maybe it was intended that someone go through and mark all the version
numbers as mandatory, or to state in the core spec that the second
element in each sub-sequence was optional, but neither of these has
happened.

	- Steven
-- 


**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

**********************************************************************



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
