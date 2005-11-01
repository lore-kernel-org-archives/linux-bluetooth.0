Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Some thoughts on the current D-BUS interface
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <3013cac80511011105y2be7647bi4fb0994efd6f8a31@mail.gmail.com>
References: <20051031224006.GA14057@localhost.localdomain>
	 <1130799900.31561.38.camel@blade>
	 <20051031233610.GA14937@localhost.localdomain>
	 <e1effdeb0511010433x11bbef22q8648e30b565cf41c@mail.gmail.com>
	 <20051101155447.GA26044@localhost.localdomain>
	 <1130863617.31561.74.camel@blade>
	 <3013cac80511011105y2be7647bi4fb0994efd6f8a31@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1130874835.5048.12.camel@blade>
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
Date: Tue, 01 Nov 2005 20:53:55 +0100

Hi Eduardo,

> here is the device Up and Down dbus methods.

the patch is in the CVS now. However I am not sure about the future of
any of these two methods. Do we really want the possibility to up and
down a Bluetooth adapter?

For the test scripts, make sure that you include "#!/usr/bin/python" on
the first line and I basically like one or two bigger test scripts. An
extra script for every method is overkill.

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
