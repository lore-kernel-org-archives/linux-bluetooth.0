Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] PAN profile of bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: blookk - <blookk@hotmail.com>
Cc: bluez-devel@lists.sf.net
In-Reply-To: <BAY1-F25PMxBZMBDC9p000456a6@hotmail.com>
References: <BAY1-F25PMxBZMBDC9p000456a6@hotmail.com>
Content-Type: text/plain
Message-Id: <1093880093.5620.82.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 30 Aug 2004 17:34:53 +0200

Hi,

> I have made a new try and it don't work.
> 
> after  I do all things that you told me, when  I execute "ifconfig" the 
> virtual interface Bnep0 don't appears.

check with "ifconfig -a", because if it is still unconfigured it
wouldn't be shown otherwise.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
