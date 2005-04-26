Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <426E5CCC.2030108@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] implementing security mode 2 or 3
References: <426E0C5A.8060203@gmx.ch> <200504261153.08434.bluez-user@schaettgen.de>
In-Reply-To: <200504261153.08434.bluez-user@schaettgen.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Tue, 26 Apr 2005 17:22:52 +0200

Thank you, this works great with a 2.6.11 kernel.
Unfortunately I'm bound to kernel 2.4.26 or 2.6.7.
2.4.26 doesn't work. It just let's remote devices connect...
Do you know if 2.6.7 will?

If not, which part of the kernel has to be fixed? Is it a part of bluez?
Can this encryption be reached in another way?

Where are the link keys saved? I'm unable to find them.

Is there something that has to be paid attention to if I do encryption like 
this? Does the password/Dongle/... influence the encryption strength?

regards
Marco


Fred Schaettgen wrote:
> On Tuesday, 26. April 2005 11:39, Marco Trudel wrote:
> 
>>I've two rfcomm service running on different channels.
>>I wish to have one channel authenticated/encrypted, the other
>>unathenticated(unencrypted).
>>
>>As much as I know, that means that security mode 3 won't work, security
>>mode 2 has to be used and I've to program this myself.
>>
>>Does this mean that I've to request authentication/encryption on incoming
>>connections? 
> 
> 
> Yes.
> 
> 
>>How can I do that using bluez? 
> 
> 
> int opt = RFCOMM_LM_AUTH | RFCOMM_LM_ENCRYPT;
> setsockopt(s, SOL_RFCOMM, RFCOMM_LM, &opt, sizeof(opt));
> 
> 
>>Will this provide less security/encryption than using security mode 3?
> 
> 
> No, but you will need a recent kernel. For older kernels it will simply not 
> work, and IIRC the call even failed silently without reporting an error in 
> one kernel version. Can't remember which one it was though. 2.6.8 or 9 maybe?
> 
> Fred
> 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
