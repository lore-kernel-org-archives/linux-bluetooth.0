Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Achim Bohnet <ach@mpe.mpg.de>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] Bluetooth address specific device configuration
References: <1075316178.553.18.camel@akka.yeti.nocrew.org> <1075317841.553.22.camel@akka.yeti.nocrew.org>
In-Reply-To: <1075317841.553.22.camel@akka.yeti.nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200401290016.05166.ach@mpe.mpg.de>
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
Date: Thu, 29 Jan 2004 00:16:05 +0100

On Wednesday 28 January 2004 20:24, Fredrik Noring wrote:
> ons 2004-01-28 klockan 19.56 skrev Fredrik Noring:
> >    device 00:11:22:33:44:55
> >    {
> > 	# Device options for bdaddr 00:11:22:33:44:55...
> >    }
> 
> Btw., a variation on the theme is to allow:
> 
>    device hci0
>    {
> 	# Device options for interface hci0...
>    }
> 
> I don't know which one is most useful or if both should be allowed.

I've a laptop with buildin bt and an external bt stick.  It depends on the
order I switch internal one on or connect the stick what interface is
assigned to the same hardware.  If there is a need (no idea yet I'm
a bt newbie) for this feature selection by bdaddr is therefore useful
to support.  Selection by interface would be useless for me.

On the other hand if I ever take the another identical stick with me
by accident, bdaddr would be different  and the settings would not
apply without a notice.  Maybe a 

	device default
	{
	    complain loudly
	}

is useful ;)

Achim
> 
> Fredrik
> -------------------------------------------------------
> The SF.Net email is sponsored by EclipseCon 2004
> Premiere Conference on Open Tools Development and Integration
> See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
> http://www.eclipsecon.org/osdn
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 
> 
> 

-- 
  To me vi is Zen.  To use vi is to practice zen. Every command is
  a koan. Profound to the user, unintelligible to the uninitiated.
  You discover truth everytime you use it.
                                      -- reddy@lion.austin.ibm.com



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
