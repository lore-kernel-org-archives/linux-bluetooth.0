Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Device specific pins
From: Marcel Holtmann <marcel@holtmann.org>
To: Dave Henriksen <dhenriksen@optibrand.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1075157711.3751.1.camel@linux.local>
References: <1075153448.2906.2.camel@linux.local>
	 <1075151423.25442.135.camel@pegasus>  <1075157711.3751.1.camel@linux.local>
Content-Type: text/plain
Message-Id: <1075159575.5234.1.camel@pegasus>
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
Date: Tue, 27 Jan 2004 00:26:15 +0100

Hi Dave,

> Thanks for the reply.   Are you saying that the BD_ADDR gets passed into
> the pin helper script as a parameter ?  Or is it an environment variable
> that I can reference within my pin_helper script ?

it is a parameter. For more details look at utils/hcid/security.c at
line 254ff.

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
