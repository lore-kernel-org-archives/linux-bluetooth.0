Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hci_create_connection assuming timeout too soon
From: Marcel Holtmann <marcel@holtmann.org>
To: Andreas Gaufer <andreas.gaufer@blue-cell-networks.com>
Cc: Bluez Devel <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040609154824.531c71b8.Andreas.Gaufer@blue-cell-networks.com>
References: <20040609154824.531c71b8.Andreas.Gaufer@blue-cell-networks.com>
Content-Type: text/plain
Message-Id: <1087033515.4306.0.camel@pegasus>
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
Date: Sat, 12 Jun 2004 11:45:16 +0200

Hi Andreas,

> I noticed that many tools that use hci_create_connection use a hard coded 
> timeout-value that varries between 1000 and 25000. 1000 is much to short for 
> most mobile phones. 
> 
> This leads to error messages even if the chip didnt report a "connection 
> complete" yet. Very often a conection complete with 00 is reported 
> later but the tool did exit already.
> 
> IMHO we could rely on the chips page timeout and wait for its "connection
> complete" event. This timeout can also be changed with hciconfig pageto 
> by the user.
> 
> To catch a condition where the chip is stalled in some way i think the best 
> approach would be to time out on host side after the chips 
> page time out * 1,5 or so.
> 
> I changed hcitool to make it possible to specifiy the host side
> timeout via command line but i dont belive that this is a good aproach because
> it only fixes the symthoms not the root of the problem. Anyways I attach the 
> patch against the latest CVS-HEAD to show what im talking about.
> 
> In the moment my time is extremly short, i will try to bring up some code 
> that realy helps here later. Since im not that familiar with C please let me 
> know if somethings not right with my changes.

your change is me too much at the moment. I simply changed the timeout
to 25000 for the hcitool cc command.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
