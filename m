Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Windows Port
From: Marcel Holtmann <marcel@holtmann.org>
To: "Antony C. Roberts" <acr@acroberts.com>
Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <40176BC2.9020307@acroberts.com>
References: <50BF37ECE4954A4BA18C08D0C2CF88CB04B83F@exmail1.se.axis.com>
	 <1075276388.12766.49.camel@pegasus>  <40176BC2.9020307@acroberts.com>
Content-Type: text/plain
Message-Id: <1075277296.12766.63.camel@pegasus>
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
Date: Wed, 28 Jan 2004 09:08:16 +0100

Hi Antony,

> I have no problem with GPL in the RFCOMM and L2CAP bits. My aim is to 
> have a sub-system (set of services) which are accessible from an API. 
> The RFCOMM and L2CAP bits can remain GPL no problem. The driver would be 
> open-source (but not GPL) as would the API itself and any user mode apps.

be very careful with putting your code not under GPL. You should read
what the FSF says about derived work etc. Actually this would be another
reason for me to start from scratch.

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
