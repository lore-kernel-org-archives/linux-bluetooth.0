Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42D2AEFA.6080401@soft.uni-linz.ac.at>
From: Simon Vogl <vogl@soft.uni-linz.ac.at>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] zeevo module on uart
References: <42D2505A.6070206@soft.uni-linz.ac.at> <1121102289.5934.1.camel@notepaq>
In-Reply-To: <1121102289.5934.1.camel@notepaq>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 11 Jul 2005 19:40:10 +0200

Thanks Marcel,
just wanted to know if there are some obvious limitations - I will play 
around with
the hardware settings a little bit more ;)
have a nice evening,
simon

Marcel Holtmann wrote:

>Hi Simon,
>
>  
>
>>I am trying to talk to a Zeevo BT module (tc2001p chip on it) which is
>>attached to an xscale processor via serial.
>>When I start hciattach, I get an error message (and I cannot talk to the
>>device later on):
>>
>>root@tinypxa263:~# hciattach ttyS1 any
>>h4_recv: Unknown HCI packet type f1
>>
>>The current kernel is 2.4.19-rmk7-pxa2 +local patches, bluez* 2.18
>>Is this a kernel issue or is something else in my setup wrong?
>>    
>>
>
>the support for the 2.4 kernel series is limited as you now. So I can't
>provide you any details. However if the Zeevo module capable of working
>with H:4 and doesn't need any special initialization, then this can only
>mean the the serial port or baud rate settings are wrong.
>
>Regards
>
>Marcel
>
>
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
>July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
>core and dual graphics technology at this free one hour event hosted by HP, 
>AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
>_______________________________________________
>Bluez-devel mailing list
>Bluez-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-devel
>  
>


-- 
_______________________________________________________________________
Dr. Simon Vogl
Institut für Pervasive Computing, Johannes Kepler Universität Linz
Altenberger Straße 69, A-4040 Linz, Austria

Tel: +43 732 2468-8517, Fax: +43 732 2468-8426
mailto: vogl@soft.uni-linz.ac.at,  http://www.soft.uni-linz.ac.at/



-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
