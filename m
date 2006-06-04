Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20060603134011.GA13263@esaurito.net>
References: <20060603134011.GA13263@esaurito.net>
Date: Sun, 04 Jun 2006 15:06:54 +0200
Message-Id: <1149426414.8053.0.camel@localhost>
Mime-Version: 1.0
Cc: bluez-devel@lists.sf.net
Subject: Re: [Bluez-devel] [PATCH] some manual pages patches
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Filippo,

> the two attached patches for l2ping and pand apply against current CVS.
> 
> The pand patch is really easy, it just appends a SCRIPTS section to explain the
> /etc/bluetooth/pan/dev-up usage, it may be worth including it in a file to be
> --included to help2man:
> 
> [SCRIPTS]
> pand will execute \fB/etc/bluetooth/pan/dev-up\fR \fIdevice\fR \fIdestination\fR
> when the interface becomes available.

both patches are applied now. Thanks.

> You may want to discard the first chunk of l2ping.1.patch as it changes the
> l2ping section from 1 to 8.
> 
> IMO section 8 (system administration commands) is more suitable at least for
> pand,hcid and hidd, being them daemons. The l2ping (for example) case is tricky, on
> a normal system it would require root privileges so it is not really a user
> command.

This is historical and might need to change that, but not right now.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
