Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] rfcomm error message?
From: Marcel Holtmann <marcel@holtmann.org>
To: Anthony Yulo <strikewing16th@hotmail.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <LAW11-OE47NCsn8BWz60002faea@hotmail.com>
References: <Law11-F41C9IHzQL9P30004988b@hotmail.com>
	 <1074689125.7088.71.camel@pegasus>
	 <LAW11-OE47NCsn8BWz60002faea@hotmail.com>
Content-Type: text/plain
Message-Id: <1074697306.7088.92.camel@pegasus>
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
Date: Wed, 21 Jan 2004 16:01:46 +0100

Hi Anthony,

> > yes you can, but in that case you have to start with RFCOMM socket
> > programming. Look at rctest for an example.
> 
> I forgot to ask about the rctest example.. i tried compiling the rctest
> example manually in directory where rctest is..
> "gcc rctest.c" ... and then there was an error saying "undefined reference
> to aparticularfunction()"..
> something like that.. what does that mean? how can i fix it?

unpack the utils source and run "./configure && make" and you will get
your rctest binary.

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
