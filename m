Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Nokia 6230: "pairing and conn. rejected for
	security reasons"
From: Marcel Holtmann <marcel@holtmann.org>
To: Lutz Pressler <Lutz.Pressler@SerNet.DE>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <E1BQ1hB-0007WA-00@intern.SerNet.DE>
References: <E1BQ1hB-0007WA-00@intern.SerNet.DE>
Content-Type: text/plain
Message-Id: <1084876340.5833.96.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 18 May 2004 12:32:20 +0200

Hi Lutz,

> > please install bluez-libs-2.7 and bluez-utils-2.7, because it looks like
> > that this phone already contains some Bluetooth 1.2 features and I need
> > to know the full 8 bytes of the remote features.
> later (work to do here :)) - probably not today.

not really needed anymore, because it looks like a bug in one of the
link managers or maybe the hardware itself.

> > like that you are in security mode 3. From your hcid.conf I saw that you
> > haven't activated auth and encrypt so this is not you, but I can't think
> tried with and without "auth enable; encrypt enable;" and with
> "lm accept;" and "lm accept,master;". No difference.

Keep auth and encrypt always off unless you really wanna activate
security mode 3.

> > It disconnects with "Pairing With Unit Key Not Supported" error (0x29)
> > and I haven't seen this error before. I am no link manager expert, but I
> > really think that one implementation is acting very bad here. And I
> > guess it is your Acer dongle with the Zeevo/Telencomm chip, because it
> > has caused troubles in the past. Do you own another dongle (preferable
> > CSR based) to check this?
> At the moment I don't think so. We also have a physically bigger Acer
> dongle (that may be "100m" variant?), but that's on the road at the
> moment. Should I order some specific model?

The best is you buy yourself a CSR based dongle with a least HCI 16.4
firmware. If you still get problems with a CSR based dongle you have to
return your phone. For specific dongle information check our hardware
lists at http://www.bluez.org/hardware.html

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
