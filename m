Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bluez & qos
From: Marcel Holtmann <marcel@holtmann.org>
To: Mauro Tortonesi <mtortonesi@ing.unife.it>
Cc: BlueZ mailing list <bluez-devel@lists.sourceforge.net>,
   Jean Tourrilhes
	 <jt@bougret.hpl.hp.com>
In-Reply-To: <200402041223.29088.mtortonesi@ing.unife.it>
References: <20040204015825.GA2217@bougret.hpl.hp.com>
	<200402041223.29088.mtortonesi@ing.unife.it>
Content-Type: text/plain
Message-Id: <1075894618.8348.14.camel@merlin>
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
Date: 04 Feb 2004 12:36:57 +0100

Hi Mauro,

> 	i was trying to do some qos setup tests with bluez and i have seen that there 
> is barely no qos support in bluez. it would be nice to develop an 
> ioctl(2)-based extension to set up qos on bluez sockets. i have just started  
> working on the code. marcel, would you be intested in having qos support for 
> bluez?

I never used any QoS feature of Bluetooth so far, but go ahead and
implement it. Please start working with a 2.6 kernel and don't worry
about showing us early and experimental code.

> BTW: i have seen that Jean Tourrilhes (included in cc) has been working on qos 
> with CSR chips a while ago. jean, since i have seen no announcements on this 
> list i suppose that you haven't production-quality code adding qos support 
> for bluez...

If my memory works right, there was a problem with older CSR firmwares
and QoS on the HCI level.

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
