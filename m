Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Some thoughts on the current D-BUS interface
Message-ID: <20051101202732.GB30490@localhost.localdomain>
References: <20051031224006.GA14057@localhost.localdomain> <1130799900.31561.38.camel@blade> <20051031233610.GA14937@localhost.localdomain> <e1effdeb0511010433x11bbef22q8648e30b565cf41c@mail.gmail.com> <20051101155447.GA26044@localhost.localdomain> <1130863617.31561.74.camel@blade> <3013cac80511011105y2be7647bi4fb0994efd6f8a31@mail.gmail.com> <1130874835.5048.12.camel@blade>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1130874835.5048.12.camel@blade>
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
Date: Tue, 1 Nov 2005 22:27:32 +0200

On Tue, Nov 01, 2005, Marcel Holtmann wrote:
> For the test scripts, make sure that you include "#!/usr/bin/python" on
> the first line and I basically like one or two bigger test scripts. An
> extra script for every method is overkill.

I think I'll do just one big script. However, I think that
"#!/usr/bin/env python" is better because it will also work if python is
installed e.g. in /usr/local/bin.

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
