Return-Path: <cyrus@holtmann.org>
Message-ID: <4A11DF29.4070408@fastmail.fm>
Date: Mon, 18 May 2009 18:20:25 -0400
From: tmm <tmm@fastmail.fm>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: Passkey-Agent for bluez 4.xx
References: <88BAD6A2A6AF68449DBBF80948806AC9014F5692@bb-corp-ex1.corp.cubic.cub> <20090518205242.256782ab@symphony> <88BAD6A2A6AF68449DBBF80948806AC9014F56F0@bb-corp-ex1.corp.cubic.cub>
In-Reply-To: <88BAD6A2A6AF68449DBBF80948806AC9014F56F0@bb-corp-ex1.corp.cubic.cub>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Wilson, Scott wrote:
> All,
>
> Regarding my earlier post and the reply by James Le Cuirot:
>
>   
>>> My question is, how hard would it be to fix the agent.c code myself?
>>>       
>
>   
>> Most of the work has been done, I believe. You should speak to Alan
>> Carvalho de Assis at acassis@gmail.com.
>>     
>
>   
>> James
>>     
>
> I have some additional questions:
>
> While on the "full" Linux operating system (on a PC), some type of agent
> is installed and executed for me in that environment.  Where is this
> agent coming from?  How is it being executed for me? To my knowledge, I
> have never installed an agent or configured one.
>   
I'm not an expert on this, but I'll try to answer.

Both Gnome and KDE have their own agents, as part of their bluetooth 
management software.

The dbus and bluez on your embedded platform are probably the same as on 
a desktop distro, but this depends on which embedded platform/distro you 
are using.  There is no agent included with dbus or with a standard 
installation of bluez.  Bluez does contain the sample agents that you 
have already found, but they are not installed as part of bluez - they 
are just samples.  So, it's not that the dbus agent gets installed on 
desktop PC and not on embedded - it's that the dbus based agents are not 
really part of dbus, they are part of Gnome or KDE and you are not 
installing those.

Earlier in this thread it was mentioned that someone is already working 
on upgrading the v3 'C' sample agent to v4.  If you don't want to use 
Python then I think that that is what you want.

Tom.

> I can't seem to find many agent interactions in the Bluez code -
> although I find references to it.  Not surprisingly, the main agent
> reference is in test/agent.c.
>
> When I go to execute my project on my embedded device, there is no
> agent.  From all other aspects that I am aware of, the other things
> (dbus, bluez, etc) seem to be similar (my team has already tackled those
> challenges - although some may still remain).
>
> Is it possible that this agent is not included with the dbus that runs
> on the embedded device, but is on the PC?  Does Gnome include this
> agent?  Does it come from the bluetooth-applet?
>
> Any and all comments welcome.  Thank you in advance.
>
> Regards,
>
> Scott Wilson
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   
