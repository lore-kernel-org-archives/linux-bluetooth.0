Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] Bluetooth address specific device
	configuration
From: Marcel Holtmann <marcel@holtmann.org>
To: Fredrik Noring <noring@nocrew.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Edd Dumbill <edd@usefulinc.com>
In-Reply-To: <1075564164.14644.167.camel@akka.yeti.nocrew.org>
References: <1075316178.553.18.camel@akka.yeti.nocrew.org>
	 <1075355567.26729.65.camel@pegasus>
	 <1075405154.22564.64.camel@akka.yeti.nocrew.org>
	 <1075406315.22564.67.camel@akka.yeti.nocrew.org>
	 <1075563018.2720.19.camel@pegasus>
	 <1075564164.14644.167.camel@akka.yeti.nocrew.org>
Content-Type: text/plain
Message-Id: <1075564788.2720.49.camel@pegasus>
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
Date: Sat, 31 Jan 2004 16:59:49 +0100

Hi Fredrik,

> As far as I can see there is only one misplaced space and two 
> misplaced '{' characters in the entire patch, on lines 93, 312
> and 331 in main.c. :)

I have seen more. Also misplaced comments ;)

One other thing.

static void init_device_defaults(struct device_opts *device_opts)
{
       device_opts->name        = 0;
       device_opts->class       = 0;
       device_opts->pkt_type    = 0;
       device_opts->scan        = SCAN_PAGE | SCAN_INQUIRY;
       device_opts->link_mode   = 0;
       device_opts->link_policy = 0;
       device_opts->auth        = 0;
       device_opts->encrypt     = 0;
}

This is too much and not needed, because we can use memset().

	memset(device_opts, 0, sizeof(*device_opts));
	device_opts->scan = SCAN_PAGE | SCAN_INQUIRY;

I know one function later it is used in the same style, but I don't like
it either. And of course in this case inlining the function is a good
idea.

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
