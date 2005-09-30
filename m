Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] pairing problem
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <433CF32D.1080205@ubuntu.com>
References: <432E89E8.3040809@ubuntu.com>  <432E910B.4020301@ubuntu.com>
	 <1127295068.495.19.camel@localhost.localdomain>
	 <433CF32D.1080205@ubuntu.com>
Content-Type: text/plain
Message-Id: <1128068218.4955.16.camel@localhost.localdomain>
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
Date: Fri, 30 Sep 2005 10:16:58 +0200

Hi Charles,

> >>I have a strange problem. For some reason when I boot my pc, I can't 
> >>make outgoing connections from my computer to my cellphone until I 
> >>restart bluez services(although already started at boot time, incomming 
> >>connections work fine). If I restart my computer, I have to restart 
> >>bluez services again so that outgoing connections work. I can't see 
> >>anything might cause this, it used to work fine with bluez-{utils,libs}< 
> >>2.20. Any ideas ?
> >>    
> >>
> >
> >install the latest bluez-utils-2.21 and try again. Run "hcidump -X -V"
> >to see what is going on.

looks like your PIN helper is not working. Check the syslog for messages
from hcid.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
