Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: soraberri <421246@posta.unizar.es>
Message-ID: <cvi5l2$q7m$1@sea.gmane.org>
References: <421C892E.3090200@gmx.ch> <20050223142950.53110.qmail@web60907.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Big5
In-Reply-To: <20050223142950.53110.qmail@web60907.mail.yahoo.com>
Subject: [Bluez-users] Re: sdp problem
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 23 Feb 2005 16:01:18 +0100

Hi,

Ka Kin Cheung wrote:
> Hi!
>     The strange thing is here:
>     For Linux, when my phone searched for my PC, the PC can be found and 
> then added in the "My device" list, but when I looked at "Service list", 
> none service can be found. Then I opened Windows XP and the bluetooth 
> dongle driver was installed in my PC. Then I press "update" key to 
> update services, and I found headset, synchronisation, object push and 
> file transfer in the "Service list" for my Windows PC. So, how can I do 
> for sdp in my Linux PC as my project is done on Linux? Thank you very 
> much for your kindness.
> Michael

You can advertise standard services in Linux using 'sdptool add ...' but
advertising is not the same as offering... To offer a real service, an
application has to be implemented and listening for clients at the
appropiate network protocols and ports. Maybe what it is happening in
windows is that most basic profiles are already implemented and
correctly advertised. With BlueZ you  can also advertise them in order
to be seen by a remote device, but they won't work until you don't
implement them. I hope this helps.

regards,
Luis



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
