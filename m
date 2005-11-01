Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Some thoughts on the current D-BUS interface
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20051101155447.GA26044@localhost.localdomain>
References: <20051031224006.GA14057@localhost.localdomain>
	 <1130799900.31561.38.camel@blade>
	 <20051031233610.GA14937@localhost.localdomain>
	 <e1effdeb0511010433x11bbef22q8648e30b565cf41c@mail.gmail.com>
	 <20051101155447.GA26044@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1130863617.31561.74.camel@blade>
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
Date: Tue, 01 Nov 2005 17:46:57 +0100

Hi Johan,

> Here's the patch which implements the interface redesign. The change
> ended up being a little bigger than I originally thought, but I think
> the code and interface become more understandable this way. Attached is
> also a simple python app which tests the DeviceList and DefaultDevice
> methods.

let's test this new interface. The patch is in the CVS now and we will
see how it works out.

I also like to add a test script that can utilize the complete API. I
don't wanna replace hciconfig or hcitool, but an easy script for testing
is really needed.

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
