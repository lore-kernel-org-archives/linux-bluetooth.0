Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] How is the CTP in BLUEZ going?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <002601c4ebb8$4de24200$020ba8c0@heejune>
References: <4dfd570904122402134ec2fd32@mail.gmail.com>
	 <4dfd570904122509237f2a2f48@mail.gmail.com>
	 <1103995727.8758.31.camel@pegasus>
	 <4dfd570904122509451e811d7a@mail.gmail.com>
	 <1103996976.8758.34.camel@pegasus>
	 <4dfd5709041225095410f71a46@mail.gmail.com>
	 <1103997529.8758.36.camel@pegasus>
	 <4dfd570904122510081a9bfa7@mail.gmail.com>
	 <4dfd570904122510085371c17b@mail.gmail.com>
	 <4dfd57090412251011705f52be@mail.gmail.com>
	 <4dfd5709041225103246f6934c@mail.gmail.com>
	 <1104000494.8758.46.camel@pegasus> <002601c4ebb8$4de24200$020ba8c0@heejune>
Content-Type: text/plain
Message-Id: <1104125195.9393.12.camel@pegasus>
Mime-Version: 1.0
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
Date: Mon, 27 Dec 2004 06:26:35 +0100

Hi,

> I need CTP profile and PAN profile for my machine, we are devloping a residential gateway supporing voice over bluetooth (CTP) and some internet data service on phone (PAN).
> 
> I read from MH presentation meterial in 2003 Wireless Congrees that CTP is included in the future plan of BLUEZ. I would like to know how it is going.  And if it is not possible to finish in near future, please le me know the brief sketch of the desgin of CTP profile so that I can implement myself.
> CTP uses l2cap diffrent from HSP which uses sco directly. hmm, so I cannot extends the scotest utility than must extends l2ping or l2test. am I right? I have to read the detail of profile spec now. ^^;;

the cordless telephony profile application will use a L2CAP socket and a
SCO socket. I stopped working on it, because I never got my hands on a
CTP capable handset. Feel free to develop a CTP application and then
submit it for inclusion.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
