Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Thoughts about AVDTP support
From: Marcel Holtmann <marcel@holtmann.org>
To: Aarti Kumar <akmr2000@yahoo.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040605042247.96059.qmail@web52307.mail.yahoo.com>
References: <20040605042247.96059.qmail@web52307.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1086430086.16316.49.camel@pegasus>
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
Date: Sat, 05 Jun 2004 12:08:06 +0200

Hi Aarti,

> I agree that we have to keep the provision of recovery
> and reporting functionality from the start.

and there are some more, like multiplexing etc.

> The PSM value for AVDTP is 17 and the order of
> creation will determine the channel type -signal or
> media transfer. 

The PSM for AVDTP is 0x19 and this is 25 decimal ;)

> For the socket type I think it should be
> SOCK_SEQPACKET.

Any other comments about the socket type?

> Yes I do have initial part of the code that I can
> share but have nothing with SBC codec.

Please send it over, so I can see if I can integrate it or not.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
