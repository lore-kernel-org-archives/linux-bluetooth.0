Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <415C4A11.8070903@biarritx.dyndns.org>
From: jbarre <jbarre@biarritx.dyndns.org>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] [Fwd: Re: [Asterisk-Dev] New Bounty: Bluetooth Phone Support]
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 30 Sep 2004 20:01:53 +0200

Hi,

The Asterisk-Dev list is talking about bt... ounce again...

Since I'm (really) not an expert in this kind of stuff, I would like to 
have your opinion.

Here is a copy of my last reply to this list.

Note: I'm not in the bluez-devel list. Too much mail... :-(

Please don't forget to add my email address to your reply.

Thanks a lot, Jérôme.

-------- Original Message --------
Subject: Re: [Asterisk-Dev] New Bounty: Bluetooth Phone Support
Date: Thu, 30 Sep 2004 19:27:03 +0200
From: jbarre <asterisk@biarritx.dyndns.org>
Reply-To: asterisk@biarritx.dyndns.org,	Asterisk Developers Mailing List 
<asterisk-dev@lists.digium.com>
Organization: home
To: Asterisk Developers Mailing List <asterisk-dev@lists.digium.com>
References: 
<Pine.LNX.4.61.0409291639540.364@tungsten.technicality.org> 
<1096533948.415bc7bca2583@webmail.telecomlabs.net> 
<415C35ED.5050908@xmission.com>

First... I guess we should all focus on SCO support for bluez:
http://www.bluez.org/todo.html

Then... this is another step :
* -> headset
* -> cellphone

2 kind of chan_

Then... SMS (easy), least cost routing (obvious), directory synchro, and
other features.

Why don't you send the bounties to bluez???

Jérôme

(I may be wrong... but that's the way I see the bt integration stuff).

Brad Midgley wrote:
> Ozed,
> 
> In our sourceforge project, we're targeting host->headset but it 
> wouldn't be hard to make the leap to host->cellphone.
> 
> FYI, after some input here and over at the alsa project, I think the 
> bluetooth-alsa stuff needs tighter kernel integration and needs to work 
> with either hotplug or dbus.
> 
> check out the btp on digium cvs server that trclark mentioned for a 
> start from the asterisk side.
> 
> Brad
> 
> ooseghale@telecomlabs.net wrote:
> 
>> Hi Nate,
>>   I will be intereseted in working on an asterisk bluetooth channel.  
>> I worked on a bluetooth projector back in college and I think I can 
>> transfer some of that knowledge to this project.  Cheers
>> Ozed
>> Quoting Nate Carlson <natecars@natecarlson.com>:
>>
>>
>>> Hey all,
>>>
>>> Jay Milk and I have sponsored a new bounty to get Bluetooth phone 
>>> support added to Asterisk - that is, the Asterisk host has a 
>>> bluetooth dongle, and can send/receive calls via a Bluetooth cell phone.
>>>
>>> See:
>>>
>>> http://www.voip-info.org/wiki-Asterisk+bounty+bluetooth+cell-phone+support 
>>>
>>>
>>> The pot's at $150 right now.
>>>
>>> ------------------------------------------------------------------------
>>> | nate carlson | natecars@natecarlson.com | http://www.natecarlson.com |
>>> |       depriving some poor village of its idiot since 1981            |
>>> ------------------------------------------------------------------------
>>> _______________________________________________
>>> Asterisk-Dev mailing list
>>> Asterisk-Dev@lists.digium.com
>>> http://lists.digium.com/mailman/listinfo/asterisk-dev
>>> To UNSUBSCRIBE or update options visit:
>>>   http://lists.digium.com/mailman/listinfo/asterisk-dev
>>>
>>
>>
>>
>>
>>
>> -------------------------------------------------
>> This mail sent through IMP: http://horde.org/imp/
>> _______________________________________________
>> Asterisk-Dev mailing list
>> Asterisk-Dev@lists.digium.com
>> http://lists.digium.com/mailman/listinfo/asterisk-dev
>> To UNSUBSCRIBE or update options visit:
>>    http://lists.digium.com/mailman/listinfo/asterisk-dev
> 
> _______________________________________________
> Asterisk-Dev mailing list
> Asterisk-Dev@lists.digium.com
> http://lists.digium.com/mailman/listinfo/asterisk-dev
> To UNSUBSCRIBE or update options visit:
>   http://lists.digium.com/mailman/listinfo/asterisk-dev


_______________________________________________
Asterisk-Dev mailing list
Asterisk-Dev@lists.digium.com
http://lists.digium.com/mailman/listinfo/asterisk-dev
To UNSUBSCRIBE or update options visit:
   http://lists.digium.com/mailman/listinfo/asterisk-dev



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
