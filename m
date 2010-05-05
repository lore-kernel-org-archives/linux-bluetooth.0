Return-Path: <cyrus@holtmann.org>
Subject: Re: HDP proposed API
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
In-Reply-To: <1272959741.2182.123.camel@mosquito>
Date: Tue, 4 May 2010 21:32:36 -0300
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <43D728B9-46D9-4DA8-B41F-F3C7B895B8C8@signove.com>
References: <1272959741.2182.123.camel@mosquito>
To: Santiago Carot-Nemesio <scarot@libresoft.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Due to damn SCRUM reviews/meetings, I did not have time to make a good comparison between the two APIs, so I chose to reply directly to keep the ball rolling.

> Service		org.bluez
> Interface	org.bluez.HdpSession
> Object path	[variable prefix]/{hci0,hci1,...}/{hdp0,hdp1,...}

If we could agree on a "one process application = at most one HDP service record", we would not need this /hdpX suffix at all.

An HDP session path would be interesting if other processes should be able to talk to this object too, but as far as I can see, this is something we definetively *don't* want :)

> 		uint8 AllocateMdep(uint8 role)
> 		void AddFeature(uint8 mdepid, uint16 dtype, string dscr)
> 		void Start()

As I have already said via IRC, I prefer "my" approach: passing a dict once with all these things at once. If the idea was to confine the MDEP handling, the dict can elide mentioning MDEPs at all, and use some application-attributed handle.

> 		object Connect(string btaddr)

This has been commented by von Dentz.

> Service		org.bluez
> Interface	org.bluez.HdpDevice
> Object path	[variable prefix]/{hci0,hci1,...}/{hdp0,hdp1,...}/dev_XX_XX_XX_XX_XX_XX
> 
> 		boolean Echo(array{byte})

This is something our API does not have, we would have to add.

> 
> HDPAgent hierarchy
> ==================
> 
> Service         unique name
> Interface       org.bluez.HdpAgent
> Object path     freely definable

What I liked in your Agent, that "mine" does not have, is device connected/device disconnected callback. Our proposal relied on listening D-BUS signals to know about new devices (which may not implement HDP). This is very handy for the application, in particular when it wants to take the initiative and connect to the device. The rest, as you said, looks like our Agent.