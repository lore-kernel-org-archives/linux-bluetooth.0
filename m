Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20050223020808.14745.qmail@web52803.mail.yahoo.com>
From: Shawn Rutledge <e_cloud@yahoo.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] SDP queries when authentication/encryption are turned on
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
Date: Tue, 22 Feb 2005 18:08:07 -0800 (PST)

If in hcid.conf I use these lines:

        auth enable;
        encrypt enable;

then when I do sdptool browse or sdptool search, it keeps prompting me
to bond with every Bluetooth device that it discovers.  This does not
make sense, because the whole point of service discovery is to decide
what device you want to connect to, before having to bond with it.  If
the device was requiring a bond before answering an SDP query, fine,
but the devices I have tested with do not - they will answer SDP
queries just fine without a bond, as long as I have commented out those
two lines in hcid.conf.  Maybe this is a bug - IMO bluez should
probably ignore those settings for SDP, and always do SDP insecurely. 
Otherwise "sdp search" becomes very impractical.  At my office often 20
or more devices will be involved in such a search, belonging to various
coworkers, some of whom I have not met, and I certainly do not want to
bond with all those devices; but I also do not want to turn off
authorization completely just so that I can do sdp queries.


=====
. _______  Shawn T. Rutledge / KB7PWD ecloud@bigfoot.com
 (_  | |_)    http://ecloud.org/  kb7pwd@kb7pwd.ampr.org
 __) | | \______________________________________________


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
