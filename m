Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Nokia 6230: "pairing and conn. rejected for security reasons" 
In-reply-to: "Marcel Holtmann"'s message of "Tue, 18 May 2004 11:22:30 +0200."
             <1084872149.5833.72.camel@pegasus>
Message-ID: <13082.1084873159@csr.com>
From: Peter Stephenson <pws@csr.com>
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
Date: Tue, 18 May 2004 10:39:19 +0100

Marcel Holtmann wrote:
> > Requesting information ...
> >         BD Address:  00:E0:03:39:C9:AB
> >         Device Name: Nokia 6230 LP
> >         LMP Version: 1.1 (0x1) LMP Subversion: 0x380
> >         Manufacturer: Cambridge Silicon Radio (10)
> >         Features: 0xbf 0xee 0x00 0x09
> >                 <3-slot packets> <5-slot packets> <encryption> <slot offset
> >
> >                 <timing accuracy> <role switch> <sniff mode> <RSSI>
> >                 <channel quality> <SCO link> <HV3 packets> <u-law log>
> >                 <A-law log>
>
> please install bluez-libs-2.7 and bluez-utils-2.7, because it looks like
> that this phone already contains some Bluetooth 1.2 features and I need
> to know the full 8 bytes of the remote features.

Below HCI, at least, it's 1.1 only.  I'm surprised you're not seeing
at least CVSD and almost certainly power control --- could the third and
fourth bytes be scrambled somehow?

pws


**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

This footnote also confirms that this email message has been swept by
MIMEsweeper for the presence of computer viruses.

www.mimesweeper.com
**********************************************************************



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
