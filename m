Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluez-sdp depreciated? Was Which fedora core?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1101415238.3485.10.camel@localhost.localdomain>
References: <cnhnd6$toe$1@sea.gmane.org>  <1100769119.7164.17.camel@pegasus>
	 <1100798738.3439.4.camel@localhost.localdomain>
	 <1100803683.7164.74.camel@pegasus>
	 <1100808919.3433.12.camel@localhost.localdomain>
	 <1100813353.7164.87.camel@pegasus>
	 <1100861560.7136.49.camel@baroque.rococosoft.com>
	 <1101329008.3773.10.camel@localhost.localdomain>
	 <1101350779.7538.19.camel@pegasus>
	 <1101415238.3485.10.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1101423315.6465.25.camel@pegasus>
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
Date: Thu, 25 Nov 2004 23:55:15 +0100

Hi Phil,

> I have got bluez working with the rpms from Fedora core 2 and have gone
> back to trying the later rpms.
> 
> I now have the following installed 
> bluez-bluefw-1.0-6.i386.rpm       
> bluez-pin-0.23-3.i386.rpm
> bluez-hcidump-1.11-1.i386.rpm     
> bluez-utils-2.10-2.i386.rpm
> bluez-libs-2.10-2.i386.rpm        
> bluez-utils-cups-2.10-2.i386.rpm
> 
> and I am back more or less where I started and running dund with the
> command
> dund --listen --msdun --channel 1 10.2.0.1:10.2.0.10
> 
> The logs return the error
> localhost dund[3561]: Failed to connect to the local SDP server. No such
> file or directory(2)
> 
> In the /usr/lib there are two files
> libbluetooth.so.1       
> libbluetooth.so.1.0.10
> 
> I have tried symbolic linking them both to various combinations of
> libsdp.so, libsdp.so.1
> 
> Dund seems to be searching for sdp, and cannot find it.
> 
> Anyone any ideas how I make dund work again?

this sound like you are mixing library version and programs. Check if
the previous packages are fully installed and the old ones are removed.
Maybe they are still there, but in a different location. And check if
sdpd is running.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
