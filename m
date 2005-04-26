Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Fred Schaettgen <bluez-user@schaettgen.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] implementing security mode 2 or 3
References: <426E0C5A.8060203@gmx.ch>
In-Reply-To: <426E0C5A.8060203@gmx.ch>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200504261153.08434.bluez-user@schaettgen.de>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 26 Apr 2005 11:53:08 +0200

On Tuesday, 26. April 2005 11:39, Marco Trudel wrote:
> I've two rfcomm service running on different channels.
> I wish to have one channel authenticated/encrypted, the other
> unathenticated(unencrypted).
>
> As much as I know, that means that security mode 3 won't work, security
> mode 2 has to be used and I've to program this myself.
>
> Does this mean that I've to request authentication/encryption on incoming
> connections? 

Yes.

> How can I do that using bluez? 

int opt = RFCOMM_LM_AUTH | RFCOMM_LM_ENCRYPT;
setsockopt(s, SOL_RFCOMM, RFCOMM_LM, &opt, sizeof(opt));

> Will this provide less security/encryption than using security mode 3?

No, but you will need a recent kernel. For older kernels it will simply not 
work, and IIRC the call even failed silently without reporting an error in 
one kernel version. Can't remember which one it was though. 2.6.8 or 9 maybe?

Fred

-- 
Fred Schaettgen
bluez-devel@schaettgen.de


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
