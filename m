Return-Path: <jbarre@biarritx.dyndns.org>
Message-ID: <4162B49B.5040202@biarritx.dyndns.org>
Date: Tue, 05 Oct 2004 16:50:03 +0200
From: jbarre <jbarre@biarritx.dyndns.org>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [Fwd: Re: [Asterisk-Dev] New Bounty: Bluetooth
 Phone Support]
References: <415C4A11.8070903@biarritx.dyndns.org> <1096617904.5403.11.camel@notepaq>
In-Reply-To: <1096617904.5403.11.camel@notepaq>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel

Thanks for your answer. I have more questions - Tell me if I'm off topic 
for the list.

> what you first need is correct ALSA-SCO-Bluetooth integration.

Yes, I understand this... my idea is (was?) to collaborate with an
existing projects, at least to get advises and have a "good" framework.

I'm trying to have an idea of the "State of the Art"... existing 
projects, what works, what doesn't works, common issues...

Since a few weeks, I have the following links in my bookmarks :

(a) Bluetooth headset driver for ALSA - snd-bt-sco
http://www.dcs.gla.ac.uk/~jp/snd-bt-sco/

According to the original site, its current status is: "this driver
is not the proper way to implement headset capabilities, and somebody
else will hopefully come up with a better solution".

(b) http://www.gargan.org/linux/snd-bt-sco/

They have patch a kernel patch for snd-bt-sco(a). And a new btsco-0.3... 
Maybe (I hope) they have the "proper" way...

(c) Handsfree and Headset support for BlueZ - 
http://www.soft.uni-linz.ac.at/_wiki/tiki-index.php?page=ProjectBluezHandsfree
I haven't tested it for the moment.

(d) kbthandsfree - http://kde-bluetooth.sourceforge.net/
It seems very advanced... but maybe to too much integrated to qt/kde, I 
will have to spend hours to "understand" the code :-) We need something 
small for telephony applications.

-> Are you aware of other free projects implementing sco features?

There is also on your web site - http://http://www.bluez.org/todo.html 
the "todo" page :
"sco audio stuff

     * Full support for SCO connections with the HCI USB driver
     * Simple API for adapters with PCM interface
     * Native integration with ALSA for Linux 2.6"

-> Is it the "correct" ALSA-SCO-Bluetooth you're talking about?

I'm also going to get in touch with projects (a)(b)(c)(d) to get more 
info... maybe some of their dev are also in bluez list?
Then, if you are interested, I could send some kind of little 
"synthesis"... for you web site.

 > PBX. You will be hit by the restrictions of the headset/handsfree
 > profiles, because they are designed for a different approach. However,

Restrictions,

-> Because of the mobile phones (harware/firware) ?

-> Or because of BT - SCO (in theorie) ?


Best regards, thanks again.

Jérôme.

///
- I'm a bad dev, I'm typing slowly... but I don't want to put my fingers 
  into something that may not work :-)
- Still not in the list, don't forget cc me.
- And my Englis isn't good since I'm French.
