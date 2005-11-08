Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] Variable arguments to Inquiry and
	PeriodicInquiry D-BUS methods
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20051108134311.GA7150@localhost.localdomain>
References: <20051108134311.GA7150@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1131458070.5824.181.camel@blade>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 08 Nov 2005 14:54:30 +0100

Hi Johan,

> Here's a patch which allows Inquiry and PeriodicInquiry to be called
> with two possible sets of parameters. We can't unfortunately get (at
> least very easily) the same flexibility that you can get with e.g.
> command line options because there are no "labels" for the D-BUS
> parameters. So, the solution I went for was that either you provide only
> the essential parameters (the ones that don't have a sane default
> value), or then you provide all parameters.
> 
> The possible ways of calling the methods after applying this patch are:
> 
> Inquiry()
> Inquiry(byte: length, byte: num_rsp, uint32: lap)
> PeriodicInquiry(byte: length, uint16: min_period, uint16: max_period)
> PeriodicInquiry(byte: length, uint16: min_period, uint16: max_period,
> 		byte: num_rsp, uint32: lap)

please swap the lap and num_rsp (call it num_responses btw.) and make
the num_responses also optional. It is more usual that you will specify
a different lap instead of num_responses. The reason for this is,
because the num_responses value is not really useful anymore. All chips
in inquiry mode 1 or 2 tend to send results multiple times and this
makes the num_responses value useless. It is only good for devices where
the memory storage for inquiry results is limited. Maybe we shouldn't
use it at all.

Is it not better to call it access_code instead of lap?

The length parameter should also be in seconds and not the slot timing
we get from the baseband.

> Then, I'd like to start some discussion about the interface for setting
> default values for certain parameters. I'd suggest to use a similar
> interface that we currently have for the properties where there are only
> two methods ("Set" and "Get") and strings are used to identify the
> parameter which should be operated on. I think it would be good to have
> each module under the device path (e.g. "Controller", "PAN", etc.)
> implement this interface. You would then do something like:
> 
> Object: /org/bluez/Device/hci0/Controller
> Interface: org.bluez.Defaults
> Method: Set("LAP", 0x9e8b00)
> 
> Object: /org/bluez/Device/hci0/Controller
> Interface: org.bluez.Defaults
> Method: Set("role", "slave")
> 
> Object: /org/bluez/Device/hci0/RFCOMM
> Interface: org.bluez.Defaults
> Method: Set("authenticate", True)
> 
> Does this sound like a sensible way to do it?

I am not unhappy with it at the moment.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
