Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hcid hotplug initialisation?
From: Marcel Holtmann <marcel@holtmann.org>
To: Fredrik Noring <noring@nocrew.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076332010.5263.98.camel@kalkyl.roxen.com>
References: <1076323204.5263.34.camel@kalkyl.roxen.com>
	 <1076323641.6869.98.camel@pegasus>
	 <1076324203.5263.47.camel@kalkyl.roxen.com>
	 <1076325635.6869.128.camel@pegasus>
	 <1076330114.5263.85.camel@kalkyl.roxen.com>
	 <1076331044.6869.152.camel@pegasus>
	 <1076332010.5263.98.camel@kalkyl.roxen.com>
Content-Type: text/plain
Message-Id: <1076340889.6869.187.camel@pegasus>
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
Date: Mon, 09 Feb 2004 16:34:49 +0100

Hi Fredrik,

> > the daemons are idle if no device is attached. So who cares?
> 
> System start is slower. Process list is cluttered. Memory is wasted.
> These are the main issues.

and starting from bluetooth.agent makes the agent script slower. It can
introduce race conditions.

If people plan to install Bluetooth, but don't plan to use it, we can
have a /etc/default/bluetooth option for deactivating hcid and co at
startup.

> > If they don't use Bluetooth, they don't even install it and so no
> > problem. 
> 
> Can I ask you: Do you use each and every single application you
> have installed on your system? :)

You won't believe it, but on my productiv systems I try to only have
applications installed that I or the system itself uses. I believe in
the way, that a minimal system is enough and if I need some other
software I install them. The Debian way with apt-get is the best I've
ever seen. I manage some system that I haven't reinstalled for over 5
years and they are as clean as I setup them.

However the bad guy is my development system, because I need hundreds of
development packages, extra tools etc. ;)

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
