Return-Path: <cyrus@holtmann.org>
Message-ID: <4B32396F.3090105@videam.com.br>
Date: Wed, 23 Dec 2009 13:38:23 -0200
From: "Daniel T. Cobra" <dcobra@videam.com.br>
MIME-Version: 1.0
To: venu <vjosyula@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Long delay to (re)connect a bluetooth mouse
References: <1260906227.4b27e6f39cc7c@www.fastmail.com.br>	 <4B2BBF58.4030901@videam.com.br>	 <1261173899.4041.96.camel@localhost.localdomain>	 <1261176544.4b2c06e0e0eae@www.fastmail.com.br>	 <1261177111.4041.99.camel@localhost.localdomain>	 <1261185699.4b2c2aa37a9c4@www.fastmail.com.br>	 <4B30B555.5000202@videam.com.br> <4B30B6FF.4090300@videam.com.br>	 <53ea87da0912222033y530c83dci41bb6d9b99ece6c@mail.gmail.com>	 <4B32336C.8080806@videam.com.br> <53ea87da0912230727q617dce1axe5053cd32d03bbf5@mail.gmail.com>
In-Reply-To: <53ea87da0912230727q617dce1axe5053cd32d03bbf5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

O.k., Venu:

I'll reverse the order of your suggestions and try getting the HCI trace 
for Windows first. As you say, comparing it to the bluez trace will 
probably throw more light into the reason for the difference in 
performance and will help make clear whether changing the code is the 
way to go. I'll post the results later.

Regards,

Daniel

P.S.: Folks, if this discussion is not appropriate for this mailing 
list, please let me know and I will continue talking to Venu privately.

Citando venu:
> Hi
>
> I work on the bluetooth protocol, but I have not worked on Bluez stack 
> at all. I have worked/working on existing protocol stack for 
> semiconductor company. When I look at the HCI Commands log, I donot 
> see any HCI Command Remote Name request, for getting the remote 
> features, I see that hci command for reading remote name request being 
> sent directly to the host. Ours is a PC Solution which has USB Transport.
>
> Even to follow, your suggestion you would need to modify the HID 
> Profile stack to effect that. 
>
> But if you can get HCI Logs for windows for your case and compare it , 
> it would throw light what/where the problem could be.
>
> Cheers,
> Venu

