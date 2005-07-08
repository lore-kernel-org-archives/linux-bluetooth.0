Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb05070811375af87810@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] pand D-Bus service
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
Date: Fri, 8 Jul 2005 15:37:04 -0300

Hi Marcel,

We exchanged some emails last month about D-Bus services
for pand. I implemented some D-Bus services, but ...
How will be the relationship between the pand and the "metaserver"?
It is not clear for me how the other daemons will
interact with the current bluez-utils daemons and tools
(pand, hidd, dund, rfcomm, ...).
Could you explain me how the D-Bus services will be organized?


The current services implemented for pand are:
- daemon start/stop
- connect/disconnect
- search
- listen start/stop
- udhcp integration for local link address assigment
- automatic bridge creation (using libbridge)

The udhcp doesn't support local link address resolution
at the moment. However, there is a patch submited to busybox
community that make possible assign IP address to bluetooth
interfaces.


Regards,
Claudio.


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
