Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Windows Port
From: Marcel Holtmann <marcel@holtmann.org>
To: "Antony C. Roberts" <acr@acroberts.com>
Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4017704C.2070505@acroberts.com>
References: <50BF37ECE4954A4BA18C08D0C2CF88CB04B83F@exmail1.se.axis.com>
	 <1075276388.12766.49.camel@pegasus>  <40176BC2.9020307@acroberts.com>
	 <1075277296.12766.63.camel@pegasus>  <4017704C.2070505@acroberts.com>
Content-Type: text/plain
Message-Id: <1075306926.26729.8.camel@pegasus>
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
Date: Wed, 28 Jan 2004 17:22:06 +0100

Hi Antony,

> Thanks for the warning. The stuff I want to port will be isolated in the 
> services provided and all the code in this application will, as 
> required, still be GPL. However, the parts which interface to these 
> services (the hardware driver and the API) would be a modified GPL that 
> does not require the entire program to be made public but only the 
> original source code and any modifications made to it.

if a program contains one line GPL code, the complete source code must
be available. If you link a library under GPL, the final program will
also be GPL.

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
