Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] pand/main.c, restore signals for dev-up
	script
From: Marcel Holtmann <marcel@holtmann.org>
To: James Cameron <james.cameron@hp.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040628095541.GB8871@hp.com>
References: <20040627133325.GA23996@hp.com>
	 <1088366793.3774.70.camel@pegasus> <20040627233437.GD28828@hp.com>
	 <1088408656.3774.136.camel@pegasus> <20040628085356.GA8871@hp.com>
	 <1088413518.3774.167.camel@pegasus>  <20040628095541.GB8871@hp.com>
Content-Type: text/plain
Message-Id: <1088417629.3774.177.camel@pegasus>
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
Date: Mon, 28 Jun 2004 12:13:49 +0200

Hi James,

> But dev-up is given the peer's Bluetooth device address.  net.agent is not
> given this.  Can it be determined from just the interface name?  I could
> do a "hcitool con" if I knew what the right hci device number was, but
> it seems sensible to have the dev-up script provide the knowledge.

it is the same as the ethernet address of the bnep0 interfaces.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
