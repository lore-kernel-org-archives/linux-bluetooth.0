Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] still the old problem...
From: Marcel Holtmann <marcel@holtmann.org>
To: Geert Geurts <geert@ebm.nl>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1080813335.3081.38.camel@geert.ebm.nl>
References: <1080813335.3081.38.camel@geert.ebm.nl>
Content-Type: text/plain
Message-Id: <1080813841.3059.12.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 01 Apr 2004 12:04:02 +0200

Hi Geert,

> got rid of affix but still got the same old problem...
> after 1/2 min of connectivity It breaks again...  and pinging over the
> ppp gives 
> sendmsg: No buffer space available
> again...
> I've made some files wich probably says more then me whining... 
> 62.131.96.192/geert/*
> containing: hcidump,lsmod,messages,ppp-peers-dun,steps,uname-r

try to exchange the dongle or update your PalmOS. Please try it with a
2.6 kernel. However send us a binary dump made with "hcidump -w <file>".

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
