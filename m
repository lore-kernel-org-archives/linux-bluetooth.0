Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Catalin Drula <catalin.drula@imag.fr>
Message-ID: <loom.20050324T175954-608@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] Host to Host Controller flow control
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
Date: Thu, 24 Mar 2005 17:04:25 +0000 (UTC)

Hi Marcel,

I was succesful in writing a patch for handling the Hardware Error event. I have
an iPAQ h5550 with a buggy Bluetooth module from RTX Telecom. I have done some
tests after applying the patch and everything seems to be going smooth (whenever
the HW error event occurs, the application sees a "connection abort" and
synchronization is automatically regained). I will post it tomorrow along with
more detailed explanation.

I wanted to take a shot at implementing host-to-controller flow control for 
Bluez. Before I start, it'd be great to have your thoughts on this.

Thanks,

Catalin



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
