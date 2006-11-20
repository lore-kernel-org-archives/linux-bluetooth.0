Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45622169.3020708@gmail.com>
Date: Mon, 20 Nov 2006 21:43:05 +0000
From: Brian Smith <brian.john.smith@gmail.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <1163882230.3025.18.camel@TesterBox.tester.ca>	<1164011400.28397.12.camel@localhost>	<4561F690.3040608@gmail.com>
	<4561FE99.1030201@xmission.com>
In-Reply-To: <4561FE99.1030201@xmission.com>
Subject: Re: [Bluez-devel] Gumstix / speed setting in Infineon PBA31308
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Thanks for the information Brad. I'm mostly fumbling round in the dark 
with this stuff.

Do you know if the gumstix's NSSP is visible in userspace? I might have 
a poke around in the kernel and try and get the audio stream working. 
(there looks to be some docu in the kernel about it).  I think 
carwhisperer can get a SCO session open at least (I think). might play 
with that. Is your 'scoot' program available? Do you have any pointer so 
more documentation on this stuff? If the audio is streamed direct to the 
CPU once sco is opened, why is it necessary for the hci connection to 
run at 912k ? Is there a choice of whether to take the audio from hci or 
direct from pcm then?


Brad Midgley wrote:
> Brian
>
> first off: the slower speed should be ok for sco since the audio stream
> goes direct to the cpu, not through the hci connection. gumstix needs a
> kernel driver that works with the pcm connection from bluetooth and
> translates that into a kernel audio device. pcm is connected to
> gumstix's NSSP i/o (PCM-clock goes to NSSP-clock, PCM-frame goes to
> NSSP-frame, and PCM-in/out map to the NSSPTXD/TXD)
>
> (it's not relevant, but fyi: rfcomm works at a different level. For
> higher speeds what we need is for hciattach to negotiate 921k properly.
> Nobody has worked it out as far as I know. I asked on this list in May
> and Goetz Issel said he was working on this same chip in an embedded
> device but I never heard if he got it working.)
>
> Brad
>
>   
>> Hi folks.
>> Does anybody know if rfcomm can now set the baud rate on the new 
>> gumstix  Infineon PBA31308 module to the 921,600bps needed for SCO audio 
>> to work to/from it?
>>
>> Thanks,
>> Brian.
>>
>>
>> -------------------------------------------------------------------------
>> Take Surveys. Earn Cash. Influence the Future of IT
>> Join SourceForge.net's Techsay panel and you'll get the chance to share your
>> opinions on IT & business topics through brief surveys - and earn cash
>> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
>> _______________________________________________
>> Bluez-devel mailing list
>> Bluez-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>>     
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>   



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
