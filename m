Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41A3A8BF.6060802@musikcheck.dk>
From: Hasse Hagen Johansen <hhj@musikcheck.dk>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Troubles compiling btsco
References: <41A39A11.3040906@musikcheck.dk> <1101243938.27351.21.camel@pegasus>
In-Reply-To: <1101243938.27351.21.camel@pegasus>
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
Date: Tue, 23 Nov 2004 22:16:47 +0100

Marcel Holtmann wrote:

>Hi Hasse,
>
>  
>
>>I have checked out btsco from cvs from 
>>http://www.gargan.org/linux/snd-bt-sco/
>>
>>tried to run the bootstrap but i failed because the automake(on my 
>>debian sid) didn't include --ignore-deps but only had a include-deps 
>>option. I removed that
>>    
>>
>
>you need at least automake-1.6 for it and use update-alternatives to
>select the default one.
>
>  
>
>>But when running configure I get this:
>>
>>./configure: line 2919: XIPH_PATH_AO: command not found
>>    
>>
>
>Maybe you need to install the libao-dev package.
>
>Regards
>
>Marcel
>
>
>
>
>-------------------------------------------------------
>SF email is sponsored by - The IT Product Guide
>Read honest & candid reviews on hundreds of IT Products from real users.
>Discover which products truly live up to the hype. Start reading now. 
>http://productguide.itmanagersjournal.com/
>_______________________________________________
>Bluez-users mailing list
>Bluez-users@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-users
>  
>
Thank you very much. That did it :-)

/Hasse


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
