Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] AmbiCom BT2000C works with hciattach
From: Marcel Holtmann <marcel@holtmann.org>
To: Tony Lindgren <tony@atomide.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040623031119.GA20367@atomide.com>
References: <20040623031119.GA20367@atomide.com>
Content-Type: text/plain
Message-Id: <1087976062.4209.61.camel@pegasus>
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
Date: Wed, 23 Jun 2004 09:34:22 +0200

Hi Tony,

> Just FYI, there was some discussion here a while back on the 
> AmbiCom BT2000C, which is different from the earlier BT2000 
> models.
> 
> Well turns out it works fine with serial_cs + hciattach:
> 
> hciattach /dev/ttyS1 csr -s 57600 57600
> or
> hciattach /dev/ttyS1 csr -s 57600 460800
> hciconfig hci0 up
> hcitool scan
> ...
> 
> Sorry if this was already old news :) Please CC me on any 
> replies, I'm not subscribing.

how good these news are actually depends on what kernel you are using ;)

Send me the output of "dump_cis" and I will add a line to hciattach for
that. What is "hciconfig -a" saying?

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
