Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <5f30e2610603270859g44bd6f1ar1f0d2095dfeb629f@mail.gmail.com>
From: "Jeff Wilson" <jazzbotley@gmail.com>
To: bluez-devel@lists.sourceforge.net, bluez-users@lists.sourceforge.net
In-Reply-To: <20060327022132.GA20421@pisco.cs.berkeley.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20060327022132.GA20421@pisco.cs.berkeley.edu>
Subject: [Bluez-devel] DTN reference implementation version 2.2.0 release
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
Date: Mon, 27 Mar 2006 10:59:48 -0600

Using source code from BlueZ utilities as an example, and support from
the bluez mailing lists, I have worked to provide a RFCOMM-based
transport layer for a project called DTN Reference Implementation
(which derives its charter from the IETF).  From the Delay Tolerant
Networking (DTN) website:

<dtnrg.org>

What is DTNRG?

The Delay-Tolerant Networking Research Group (DTNRG) is concerned with
how to address the architectural and protocol design principles
arising from the need to provide interoperable communications with and
among extreme and performance-challenged environments where continuous
end-to-end connectivity cannot be assumed. Examples of such
environments include spacecraft, military/tactical, some forms of
disaster response, underwater, and some forms of ad-hoc
sensor/actuator networks.

</dtnrg.org>

Below is the official announcement from the DTN mailing list noting
the recently incorporated Bluetooth support.

Marcel, would it be appropriate to add DTN to the list of programs
that use BlueZ?  http://www.bluez.org/links.html

Thanks to all who have answered my questions these past few months!

    Best regards,

       Jeff Wilson
       Baylor University


---------- Forwarded message ----------
From: Michael Demmer
Date: Mar 26, 2006 8:21 PM
Subject: [dtn-users] DTN reference implementation version 2.2.0 release


This is an announcement of the 2.2.0 release of the DTN reference
implementation. The source and documentation are available at
http://www.dtnrg.org/wiki/Code.

The major changes since the last version are:

- Various changes for conformance with version 4 of the bundle
  protocol as specified in the Bundle Protocol Internet Draft, as
  released on November 2005.

- Initial implementation of custody transfer, including
  flexible per-route timing specifications for retransmissions.

- Initial implementation of a Bluetooth convergence layer from Jeff
  Wilson

- Added support for the ARM architecture, gcc 4.0, and BerkeleyDB 4.4.

- Added support for a file system based persistent storage
  implementation as an alternative to Berkeley DB.

- Many minor changes to improve stability and robustness of the code,
  largely due to an improved testing infrastructure including several
  tcl based system tests.

- Miscellaneous other improvements including: a persistent
  ForwardingLog for each bundle to maintain the history of where (and
  when) the bundle was sent to peers, restored support for reactive
  fragmentation, a NullConvergenceLayer and other testing hooks, and
  some scalability improvements.

In addition, this release is also available as a binary debian package
for the stable debian release (sarge) on x86, as well as in source
form through the apt package management system. Add the following
lines to /etc/apt/sources.list:

   deb     http://www.dtnrg.org/debian stable contrib
   deb-src http://www.dtnrg.org/debian stable contrib

The package is called 'dtn'.

Enjoy!

-mike

_______________________________________________
dtn-users mailing list
http://mailman.dtnrg.org/mailman/listinfo/dtn-users


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
