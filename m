Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Config for Socket CF card
From: Marcel Holtmann <marcel@holtmann.org>
To: digger vermont <dv_mlist@verizon.net>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>,
   Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1074814697.3159.3.camel@myrna>
References: <1074566227.3670.24.camel@myrna>
	 <1074597777.7088.2.camel@pegasus>  <1074697933.3020.19.camel@myrna>
	 <1074698544.7088.102.camel@pegasus>  <1074749699.2573.17.camel@myrna>
	 <1074775827.3071.1.camel@pegasus>  <1074814697.3159.3.camel@myrna>
Content-Type: text/plain
Message-Id: <1074816664.3071.60.camel@pegasus>
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
Date: Fri, 23 Jan 2004 01:11:04 +0100

Hi Digger,

> > The Com1 card is working fine with 2.6.2-rc1. I have no other 2.6 kernel
> > running at the moment, so please check if this is also problematic.
> 
> I rsync'd and built 2.6.2-rc1-ben1.  I'm sorry to say there is no
> difference here. I still get "BCSP initialization timed out".

so it seems that the new serial driver causes problems with some UART's.
I have no idea what caused this problem and what cards are effected. Try
to dig into it and try to solve it. Patches are always welcome.

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
