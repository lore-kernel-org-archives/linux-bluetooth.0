Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41400A1A.3010808@daimi.au.dk>
From: "Rolf E. Thorup" <rolft@daimi.au.dk>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Power level & Scan Timing
References: <413F701F.5020905@3wt.com.br>
In-Reply-To: <413F701F.5020905@3wt.com.br>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Thu, 09 Sep 2004 09:45:30 +0200

Rafael Vidal Aroca wrote:

> 
>    Hello,
> 
>    i'm playing with my dbt-120 d-link usb dongle, and i'm not managing 
> to do some things i wanted...
[...]
>    2) I'm using hcitool scan to constantly detect if my ipaq is near my 
> desktop. It seems to be really slow (from 10 to 15 seconds to 
> scan)...can this time be reduced? Does bluez do some kind of cache? (i 
> ask that because i can turn my ipaq of, and hcitool scan will not only 
> detect my ipaq anymore in about 12 seconds...)

Try `hcitool scan --help` and you will see there is an option 
--length=N. The default is 8 which according to the source of hcitool is 
approx. 10 seconds. So try with something lower than 8.

 From the help output you will also see a --flush option. Guess what 
that does ;-)

Regards
Rolf


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
