Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] Variable arguments to Inquiry and
	PeriodicInquiry D-BUS methods
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0511080645u30fb24dep3243ce434b0f07c2@mail.gmail.com>
References: <20051108134311.GA7150@localhost.localdomain>
	 <1131458070.5824.181.camel@blade>
	 <20051108143016.GA7919@localhost.localdomain>
	 <e1effdeb0511080645u30fb24dep3243ce434b0f07c2@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1131462224.5824.198.camel@blade>
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
Date: Tue, 08 Nov 2005 16:03:44 +0100

Hi Claudio,

> 1. It's better use the same method name used by device configuration.
> Currently, device configuration uses SetProperty and GetProperty, it
> should be better rename to Set and Get. Do you agree?

is HAL using something similar? If yes, then we should adapt their way.

> 2. Does it make sense add an extra argument(device class) in order to
> be notified only by device class that the client wants? Maybe this
> enhancement should be applied when become possible retrieve the
> Inquiry cache using the new userspace/kernel communication interface.

We really need this lifetime monitoring. This shouldn't be an extra
parameter, but a general filter setting for inquiry would be a good
enhancement. And we can do it all in userspace.

> 3. Periodic inquiry is a concurrent task. Currently there isn't
> verification for PeriodicInquiry requested by more than one client. In
> this case how it should work?

It should fail with somekind in progress error indication. However the
kernel should set the INQUIRY flag is an inquiry is already in progress.
I know that this work for normal inquiries, but I never checked that for
the periodic inquiry.

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
