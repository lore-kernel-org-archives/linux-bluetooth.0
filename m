Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problem trying to connect second PANU
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <6916dea20601251400g667d13edm@mail.gmail.com>
References: <6916dea20601251400g667d13edm@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1138270257.5901.22.camel@localhost>
Mime-Version: 1.0
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
Date: Thu, 26 Jan 2006 11:10:57 +0100

Hi Alexandre,

> I have 3 laptop computers running Debian Linux Kernel 2.6 and Bluez.
> My scenario is as following:
> 
> PANU1------->GN<----------PANU2
> 
> I created the connection by:
> 
> GN:
> pand --listen --role GN
> ifconfig bnep0 10.0.0.1
> 
> PANU1
> pand --connect <GN_ADDR>
> ifconfig bnep0 10.0.0.2
> 
> This connection went well and I "pinged" both each other.
> 
> So, I tried to connect the PANU2 to GN by:
> pand --connect <GN_ADDR>
> ifconfig bnep0 10.0.0.3
> 
> But I could not ping GN (10.0.0.1) anymore from PANU2.
> I tried to ifconfig bnep1 10.0.0.4 and ping it from PANU2 and no
> answer too.
> So the second slave to the piconet is no established (the first one is
> ok yet).

every PAN connection gets its own bnepX device and of you have multiple
on one side (like the GN) you need to bridge them.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
