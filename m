Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46C6FDD7.3000508@free.fr>
Date: Sat, 18 Aug 2007 16:10:31 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <46C088D7.9000108@silicom.fr>
	<46C57BA5.5000400@free.fr>	<1187348439.6698.369.camel@violet>
	<46C58673.70201@free.fr>	<5C8C496C-7E67-4DCD-A579-20E1256FA5E0@nokia.com>	<1187354654.9447.6.camel@ubuntu.mpl.access-company.com>	<E3D0E085-FDE6-4BA0-97D4-3720ABB5880C@nokia.com>	<7635988F-7113-477C-B33E-30E10DF56140@nokia.com>	<1187358839.6257.28.camel@ubuntu.mpl.access-company.com>	<1187359379.6698.388.camel@violet>
	<d89ddf300708170715g47102e93u36fa55c21bd6ddd7@mail.gmail.com>
In-Reply-To: <d89ddf300708170715g47102e93u36fa55c21bd6ddd7@mail.gmail.com>
Subject: Re: [Bluez-devel] New A2DP support : HOWTO ?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi All,

> 
> it is a little scary to think that the pulse daemon which takes up to
> 8% of my laptop's cycles when *idle* might be embedded. Fortunately
> they did just change their threading model in a devel branch.
> Hopefully the change completely removes the need for them to be
> polling from a single mainloop.
> 
> I do still like the idea of a native pulse plugin. I think they will
> get it right.

Like the idea too. :-)

Fabien

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
