Return-Path: <binch@mobilesoft.com.cn>
Subject: Re: [Bluez-users] SCO route way!!
From: Chen Bin <binch@mobilesoft.com.cn>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <1096359291.4684.26.camel@notepaq>
References: <1096249564.1725.0.camel@debian>
	 <1096359291.4684.26.camel@notepaq>
Content-Type: text/plain; charset=gb2312
Message-Id: <1096360479.2115.9.camel@debian>
Mime-Version: 1.0
Date: Tue, 28 Sep 2004 16:34:39 +0800
List-ID: <bluez-users.lists.sourceforge.net>

Hi Holtmann,

Thanks for your kind answer. I have another question. 

If the SCO is over PCM, what should I do before I write data from the
codec to the chip, just establish the connection is enough?

I mean, I use HCI ACL to add a SCO link with the chip, then I write the
voice data from the codec to the chip. I wonder if there are several SCO
connections over the chip, how can the chip determine which connection
will be used to send the voice? Should I do more steps to specify which
connection to use?

Thanks in advance.

Chen
在2004年09月28日的16:14，Marcel Holtmann写道：
> Hi Chen,
> 
> > I am developing Bluetooth on Smart Phone, I have a question about
> > bluetooth voice, I don't know whether it is suitable to ask this
> > question here. 
> 
> yes, this is the wrong mailing list until you start using Linux and
> BlueZ on your smart phone ;)
> 
> > My chip is TI BRF6100, I can change data between my board and the BT usb
> > dongle, and it can connect to the bluetooth headset, but it can't play
> > any music to it. 
> > 
> > The rfcomm connection has been connected and I can receive the AT
> > command from the headset.Using hcidump, I found that the SCO link is
> > added, but then there is no SCO traffic in the channel. 
> > 
> > The chip can support SCO data route from hci or direct to the baseband
> > from codec. I think the default choice of the chip is baseband. 
> > 
> > How can I choose the SCO route method? Is it a standard HCI command or
> > vendor-specific command? 
> 
> There are two ways, SCO over HCI and SCO over PCM. There is no standard
> HCI command to switch between them. They are all vendor specific or
> preset by the chip manufacturer and not changeable.
> 
> Regards
> 
> Marcel
> 
> 
