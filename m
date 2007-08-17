Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Frederic Dalleau <frederic.dalleau@access-company.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <d89ddf300708170715g47102e93u36fa55c21bd6ddd7@mail.gmail.com>
References: <46C088D7.9000108@silicom.fr> <46C57BA5.5000400@free.fr>
	<1187348439.6698.369.camel@violet> <46C58673.70201@free.fr>
	<5C8C496C-7E67-4DCD-A579-20E1256FA5E0@nokia.com>
	<1187354654.9447.6.camel@ubuntu.mpl.access-company.com>
	<E3D0E085-FDE6-4BA0-97D4-3720ABB5880C@nokia.com>
	<7635988F-7113-477C-B33E-30E10DF56140@nokia.com>
	<1187358839.6257.28.camel@ubuntu.mpl.access-company.com>
	<1187359379.6698.388.camel@violet>
	<d89ddf300708170715g47102e93u36fa55c21bd6ddd7@mail.gmail.com>
Date: Fri, 17 Aug 2007 16:29:06 +0200
Message-Id: <1187360946.6257.34.camel@ubuntu.mpl.access-company.com>
Mime-Version: 1.0
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


> > > Oh I see, then there is no need to write a pulseaudio specific plugin.
> >
> > we might have to do this for latency purposes. 
> I do still like the idea of a native pulse plugin. 

The guy of pulse audio had a great idea for their alsa plugin :
They put all the code in the pulse library, and the plugin only wrap the
interface.
Then the pulse library can be reused, for example in the xmms plugin
which has a different interface but similar functions...

You might consider this if you plan to write a pulse specific plugin.

Frederic

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
