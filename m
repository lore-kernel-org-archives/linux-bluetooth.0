Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] hci0 problem after timeout
From: Marcel Holtmann <marcel@holtmann.org>
To: Rafael Vidal Aroca <rafael@3WT.com.br>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <40170986.70105@3WT.com.br>
References: <40170986.70105@3WT.com.br>
Content-Type: text/plain
Message-Id: <1075276651.12766.52.camel@pegasus>
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
Date: Wed, 28 Jan 2004 08:57:31 +0100

Hi Rafael,

> 	Hi guys, i made a bluetooth network from my linux box to my ipaq  box, 
> but i'm having some problems. Both systems runs linux and bluez.
> 
> 	In PC side i use the folowing commands:
> 
> 	pand --listen --role GN
> 	hciconfig hci0 -lm master,accept
> 
> 	Then on iPaq:
> 
> 	hcitool inq
>     	pand --connect 00:80....
>    	ifconfig bnep0 192.168.2.2 netmask 255.255.255.0
> 
> 	Back to PC:
> 
>     	ifconfig bnep0 192.168.2.1 netmask 255.255.255.0
> 
> 	
> 	Doing that i can ping and ssh to my ipaq pocket pc and can also use 
> internet through pc. But just for 30 seconds!!!!
> 
> 	After about 30 seconds the conection fails and pc's dmesg shows 
> nothing. I just get and error when trying to restart hci0:
> 
> 
> 	root@gemini:~# hciconfig hci0 down	
> 	root@gemini:~# hciconfig hci0 up
> 	Can't init device hci0. Connection timed out(110)
> 
> 
> 	I really think the problem is in the pc side, and i'm having trouble 
> putting this D-Link DBT-120 usb bluetooth dongle to work since last 
> year. Can anyone help or point solutions?
> 
> 	Distro: Debian Woody
> 	Kernel: 2.4.22 (no from distro, i compiled)
> 	hotplug: 2004_01_05 (latest)
> 	bluefw: 1.0
> 	
> 	Hope i gave enough info. Thanks in advance.

give us the output of "hciconfig -a" for your devices. What kind of USB
host controller do you have (lspci)? What USB host driver do you use?

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
