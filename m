Return-Path: <linux-usb-devel-admin@lists.sourceforge.net>
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: gregkh@us.ibm.com, marcel@holtmann.org, maxk@qualcomm.com, jt@hpl.hp.com,
   perex@suse.cz, linux-dvb-maintainer@linuxtv.org, johnpol@2ka.mipt.ru,
   linux-usb-devel@lists.sourceforge.net, bluez-devel@lists.sourceforge.net,
   irda-users@lists.sourceforge.net, alsa-devel@alsa-project.org,
   linux-dvb@linuxtv.org, sensors@stimpy.netroedge.com
Subject: Re: [linux-usb-devel] [PATCH 1/63] usb/message: make usb_{control,bulk}_msg() use msecs
Message-ID: <20050215231012.GB2377@us.ibm.com>
References: <20050209001232.GC5661@us.ibm.com> <20050215222937.GA16488@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050215222937.GA16488@kroah.com>
Sender: linux-usb-devel-admin@lists.sourceforge.net
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
Date: Tue, 15 Feb 2005 15:10:12 -0800
List-ID: <bluez-devel.lists.sourceforge.net>

On Tue, Feb 15, 2005 at 02:29:38PM -0800, Greg KH wrote:
> On Tue, Feb 08, 2005 at 04:12:32PM -0800, Nishanth Aravamudan wrote:
> > Hi,
> > 
> > Sent to everyone so that build and compile tests will be possible. Only Greg
> > should need to pull this into a tree, though, to send upstream.
> 
> Ugh, 63+ patches...
> 
> Anyway, I've applied all of these, and your additional one, to my tree.
> If you could make sure and check the next -mm release to make sure I got
> them all, I'd appreciate it.
> 
> thanks a lot for your work, I appreciate it.

No problem! I will keep my eye on the USB tree in the next -MM and make
sure there aren't any stray unchanged usb_{bulk,control}_msg()s around.
Thanks for your help!

-Nish


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
