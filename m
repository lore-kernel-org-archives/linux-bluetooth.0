Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4140924F.6080504@3wt.com.br>
From: Rafael Vidal Aroca <rafael@3wt.com.br>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Power level & Scan Timing
References: <413F701F.5020905@3wt.com.br> <1094715184.5237.3.camel@notepaq>
In-Reply-To: <1094715184.5237.3.camel@notepaq>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Thu, 09 Sep 2004 14:26:39 -0300


    With Rolf suggestion, i decreased the discovery time to about 5 
seconds using lenght 2.

    Now about the transmit/receive power, i know we can see what is 
set....but the windows software allows us to controle low high or 
medium...and as i understood from this mail this kind of configuration 
can not be set with bluez.
    Is it correct or is there a way to change the power level?

again, thanks.
Rafael.


Marcel Holtmann wrote:

>Hi Rafael,
>
>  
>
>>    i'm playing with my dbt-120 d-link usb dongle, and i'm not managing 
>>to do some things i wanted...
>>
>>    1) I want to decrease the power or my dongle, cause de devices work 
>>over 20m....i want they to be detected just near the computer. I know 
>>it's possible, but could not find documentaion...so the question is: how 
>>can i decreate the power of my bluetooth adapter?
>>    
>>
>
>don't worry about it, because your Bluetooth chip does this automaticly
>and it is the job of the link manager.
>
>  
>
>>    2) I'm using hcitool scan to constantly detect if my ipaq is near my 
>>desktop. It seems to be really slow (from 10 to 15 seconds to 
>>scan)...can this time be reduced? Does bluez do some kind of cache? (i 
>>ask that because i can turn my ipaq of, and hcitool scan will not only 
>>detect my ipaq anymore in about 12 seconds...)
>>    
>>
>
>Check the specification for periodic inquiry or use the HCI directly.
>You can also use the HCI socket directly and look for inquiry result
>events.
>
>Regards
>
>Marcel
>
>
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by BEA Weblogic Workshop
>FREE Java Enterprise J2EE developer tools!
>Get your free copy of BEA WebLogic Workshop 8.1 today.
>http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
>_______________________________________________
>Bluez-users mailing list
>Bluez-users@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-users
>  
>



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
