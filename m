Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] hci0 problem after timeout
From: Marcel Holtmann <marcel@holtmann.org>
To: Rafael Vidal Aroca <rafael@3WT.com.br>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <40182154.6030709@3WT.com.br>
References: <40170986.70105@3WT.com.br> <1075276651.12766.52.camel@pegasus>
	 <4017D6E9.6030700@3WT.com.br> <1075306737.26729.3.camel@pegasus>
	 <40182154.6030709@3WT.com.br>
Content-Type: text/plain
Message-Id: <1075323686.26729.41.camel@pegasus>
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
Date: Wed, 28 Jan 2004 22:01:26 +0100

Hi Rafael,

>     Looks that the dongle problem was solved, but the connection still 
> fails after some time (a bit more now).
> 
>     I changed from uhci to usb-uhci and now I can issue hciconfig hci0 
> up and down how many times I want without any problems. Seems that the 
> PC box is clear now.
> 
>     Now the question is: are IP connections using pand reliable? May not 
> pand be the problem?
>    
>     Just to mention, after the failed connection, i have to disable and 
> enable bluetooth again on ipaq, because hcitool inq causes a message 
> "timed out".

the iPAQ contains a CSR chip with an old firmware and maybe the interop
between the Broadcom and the CSR Bluetooth chips is not very good. If
you have access to another CSR based USB dongle please try this and tell
us if the BNEP connection is still failing.

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
