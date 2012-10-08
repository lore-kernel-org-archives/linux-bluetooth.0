Return-Path: <cyrus@holtmann.org>
From: <Michal.Labedzki@tieto.com>
To: <johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
Date: Mon, 8 Oct 2012 17:19:05 +0300
Subject: RE: Wireshark
Message-ID: <E50901D4F2CF69428D43141B7C8586793514C59580@EXMB03.eu.tieto.com>
References: <E50901D4F2CF69428D43141B7C8586792CFACCF505@EXMB03.eu.tieto.com>
 <20120928135747.GD8184@aemeltch-MOBL1>
 <E50901D4F2CF69428D43141B7C8586792CFACCF507@EXMB03.eu.tieto.com>,<20121003080438.GA11960@x220>
In-Reply-To: <20121003080438.GA11960@x220>
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> I think you must have misunderstood what I was trying to say. Did you
> actually look into what the monitor socket we talked about is? I wasn't
> trying to say wireshark shouldn't be used (so no point in iterating it's
> benefits - you've already convinced me) but that its Bluetooth decoding
> support be ported from traditional HCI sockets to use monitor sockets
> instead. This wouldn't give us any new decoders to wireshark but it
> would allow early HCI traffic decoding (e.g. on plugged in USB dongles)

Hmm... Do you mean something like: 
https://bugs.wireshark.org/bugzilla/show_bug.cgi?id=5032

I will look at that and I this is on my TODO list. But please note that my first goal is add
full Bluetooth stack support to Wireshark (profiles and protocols). When this will be done I want to and other stuff like BToverUSB, etc.

The purpose of my visit here is fetch some needed logs for testing new dissectors and present this new tool to all Bluetooth developers here.
And of course I very like new idea.

New monitor sockets is not very important for now, I focus on decoding dump files (I do not have any real devices to live-capture testing). 
It is ok for future. By the way, this sounds like task for libpcap, not really Wireshark (by I am not familiar with internals yet)

> which isn't possible with current wireshark or hcidump and context
> discovery when tracing is started after there already exists
> connections.

> Considering these benefits monitor sockets compared to HCI ones is it
> something you might be interested in implementing?

Is that stable? 

Hmmm... Has anyone logs? :)

Regards / Pozdrawiam
-------------------------------------------------------------------------------------------------------------
Micha³ £abêdzki
ASCII: Michal Labedzki
e-mail: michal.labedzki@tieto.com
location: Poland, Wroc³aw, Legnicka 55F
---
Tieto Corporation / Tieto Poland
http://www.tieto.com / http://www.tieto.pl
---
Tieto Poland spó³ka z ograniczon± odpowiedzialno¶ci± z siedzib± w Szczecinie, ul. Malczewskiego 26. Zarejestrowana w S±dzie Rejonowym Szczecin-Centrum w Szczecinie, XIII Wydzia³ Gospodarczy Krajowego Rejestru S±dowego pod numerem 0000124858. NIP: 8542085557. REGON: 812023656. Kapita³ zak³adowy: 4 271500 PLN
