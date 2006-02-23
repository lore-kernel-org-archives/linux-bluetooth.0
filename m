Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] pand multiconnection patch
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <43FDBDDD.7030209@fillibach.de>
References: <43FDBDDD.7030209@fillibach.de>
Content-Type: text/plain
Message-Id: <1140703850.24721.42.camel@localhost>
Mime-Version: 1.0
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
Date: Thu, 23 Feb 2006 15:10:50 +0100

Hi Kosta,

> I am currently trying to build a (somewhat small) IP-based ad-hoc 
> network using bluetooth. In order to do this, I need pand to create 
> multiple connections. (see maxconn switch)
> 
> One problem with bluetooth is that while inquiring, sending payload data 
> is somewhat impaired. This is why I added a new switch inqint, which 
> reduces the number of inquiries made: If there is at least one 
> connection, inquire every inqint seconds, else inquire every persist 
> seconds (which is the current behavior in cvs).
> 
> Furthermore, I want to send real-time-critical data over the link (i.e. 
> VoIP), and do not want any inquiries made during these periods. That's 
> why I introduced a lockfile switch. If the lockfile cannot be 
> writelocked, no inquiries are made if there is at least one connection.
> 
> I have tested this patch "at home", but only with up to 3 bluetooth 
> devices. I seems to work. I will do further tests during the next weeks. 
> If I find any errors, I'll submit the fixes.
> 
> If you do not like the lockfile, I can send you a patch without it.

the patch is too big for a full review. Please split it up into multiple
logical parts. It is much easier for me to review small patches and then
it is more likely that I am going to accept them.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
