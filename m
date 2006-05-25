Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4475D2DC.304@killesreiter.de>
From: Gerhard Killesreiter <gerhard@killesreiter.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: broadcom in disguise...
References: <4461A33F.1060702@killesreiter.de> <44634846.3000006@xmission.com> <Pine.LNX.4.63.0605111727560.7379@redbean.intranet.gw-instruments.de> <4461FE7D.3050108@killesreiter.de> <447105B1.3060908@killesreiter.de> <447140B7.2090100@xmission.com> <44718942.10609@killesreiter.de> <4471DE09.5050405@xmission.com>
In-Reply-To: <4471DE09.5050405@xmission.com>
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
Date: Thu, 25 May 2006 17:53:00 +0200

Brad Midgley wrote:

Hi Brad!

>>> A couple of manufacturers switched from csr to broadcom around the time
>>> bluecore4 and the other edr chips came out. Not sure why.
>>>   
>>>       
>> I find this highly annoying. I have written to typhoon and asked for an
>> explanation.
>>     
>
> this is unfortunately a fairly standard practice across the computer
> hardware industry.
>   

If they'd at least update their docs...

Anyway, I got an anwer from them (didn't really expect one)!

They claim that the chip can be addressed by the broadcom driver but 
would definitly be a CSR chip.

Does that make any sense to anybody?




> bluetake has done the switcheroo as well but currently their BT007EX is
> our only source for a class 1 bluecore4 dongle so we like them again.
>
>   
>>>  If you've used the adapter in windows
>>> for sco audio
>>>  then it might change some nvram settings.
>>>       
>
> I really don't know much about the broadcom models or even if they do
> have nvram settings for this. It's possible they ship something that
> can't do sco out of the box but will do it after the windows driver
> initializes it. That's my "all out of ideas" suggestion.
>   

Guess I will need to take it to a windows box then.

Cheers,
    Gerhard


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
