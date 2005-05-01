Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42752DAC.2090803@citromail.hu>
From: =?ISO-8859-2?Q?Szil=E1gyi_Szilveszter?= <sszilveszter@citromail.hu>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Can't connect RFCOMM socket: Resource	temporarily
 unavailable
References: <4275103E.3040208@citromail.hu> <1114968717.21785.76.camel@pegasus>
In-Reply-To: <1114968717.21785.76.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
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
Date: Sun, 01 May 2005 21:27:40 +0200

yes you are right
I did not know that I had bad parameters in /etc/bluetooth/hcid.conf
in line
pin_helper /usr/bin/bluez-pin
the /usr/bin/bluez-pin was bad link
thank you!
you helped me to understand it deeper!

Marcel Holtmann írta:

>Hi,
>
>  
>
>>i cannot connect my SonyEricsson T68 on bluetooth (i tried with a Z600 
>>as well, same problem)
>>on google there is no solution
>>root:~# rfcomm connect 0 00:09:D9:26:70:46 2kr
>>(((on my phone accept and enter the pin:1111)))
>>Can't connect RFCOMM socket: Resource temporarily unavailable
>>root:~# (((I tried it as rfcomm connect 0 00:09:D9:26:70:46 1 as well)))
>>any ideas?
>>    
>>
>
>run "hcidump -X -V" as root while connecting, but I think that you have
>problems with your PIN helper. Look at the mailing list archives for
>more details.
>
>Regards
>
>Marcel
>
>
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by: NEC IT Guy Games.
>Get your fingers limbered up and give it your best shot. 4 great events, 4
>opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
>win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
>_______________________________________________
>Bluez-users mailing list
>Bluez-users@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-users
>  
>


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
