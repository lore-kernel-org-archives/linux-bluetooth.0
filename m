Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41A90E68.6000307@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] snd-bt-sco - unknown symbol snd_hwdep_new undefined!
References: <200411270038.51554.ruben@hotheads.de> <1101524868.6514.67.camel@pegasus> <200411271059.42204.ruben@hotheads.de>
In-Reply-To: <200411271059.42204.ruben@hotheads.de>
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
Date: Sat, 27 Nov 2004 16:31:52 -0700

Hi

the cvs module 'kernel' is the old way of doing things and I'll remove 
(or just empty it)

Brad

Ruben Jenster wrote:
> 
> First Marcel,
> I want to excuse my impatience. I received two confirmation e-mails this 
> morning. I'm now shure that is was the problem of my mail provider (1und1).
> But let's switch to my problem:
> 
> 
>>you may need to make "depmod -e" first or simply load the "snd-hwdep"
>>kernel module.
> 
> 
> The problem is that there doesn't exist a module called snd-hwdep.
> For my last kernel I generated a kernel patch from the cvs kernel module.
> Building only the module that is included in the cvs btsco module doesn't 
> work.
> 
> Do you have to apply the cvs kernel module although?
> 
> 
>>>>>compile process of the kernel module:
>>>
>>>22:57 root [/home/ruben/temp/btsco/btsco/kernel] : make
>>>make[1]: Entering directory `/usr/src/linux-2.6.9-gentoo-r6'
>>>  CC [M]  /home/ruben/temp/btsco/btsco/kernel/btsco.o
>>>/home/ruben/temp/btsco/btsco/kernel/btsco.c: In Funktion
>>>»snd_card_bt_sco_thread«:
>>>/home/ruben/temp/btsco/btsco/kernel/btsco.c:809: Warnung: ISO C90 forbids
>>>mixed declarations and code
>>
>>This one is now fixed in CVS.
>>
>>Regards
>>
>>Marcel
>>
>>
>>
>>
>>-------------------------------------------------------
>>SF email is sponsored by - The IT Product Guide
>>Read honest & candid reviews on hundreds of IT Products from real users.
>>Discover which products truly live up to the hype. Start reading now.
>>http://productguide.itmanagersjournal.com/
>>_______________________________________________
>>Bluez-devel mailing list
>>Bluez-devel@lists.sourceforge.net
>>https://lists.sourceforge.net/lists/listinfo/bluez-deve
> 
> l


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
