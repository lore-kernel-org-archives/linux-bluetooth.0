Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Some thoughts on the current D-BUS interface
Message-ID: <20051102095146.GA2925@localhost.localdomain>
References: <20051031224006.GA14057@localhost.localdomain> <1130799900.31561.38.camel@blade> <20051031233610.GA14937@localhost.localdomain> <e1effdeb0511010433x11bbef22q8648e30b565cf41c@mail.gmail.com> <20051101155447.GA26044@localhost.localdomain> <1130863617.31561.74.camel@blade> <20051101194822.GA29725@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051101194822.GA29725@localhost.localdomain>
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
Date: Wed, 2 Nov 2005 11:51:46 +0200

On Tue, Nov 01, 2005, Johan Hedberg wrote:
> On Tue, Nov 01, 2005, Marcel Holtmann wrote:
> > I also like to add a test script that can utilize the complete API. I
> > don't wanna replace hciconfig or hcitool, but an easy script for testing
> > is really needed.
> 
> I'll try to produce something. Hopefully I'll be able to send a first
> version to the list some time tomorrow.

I've now uploaded the first version of the script here:
http://www.iki.fi/~jhedberg/bluez-python/pybt.py

Here are some usage examples:
./pybt.py DeviceList
./pybt.py Inquiry
./pybt.py -i hci0 Inquiry 5 30
./pybt.py CancelInquiry
./pybt.py -i hci1 RemoteName 11:22:33:44:55:66
./pybt.py -i /org/bluez/Device/hci0 Up
./pybt.py -l

Johan


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
