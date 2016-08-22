Return-Path: <linux-serial-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [RFC PATCH 0/3] UART slave device bus
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20160822100936.19fd809f@lxorguk.ukuu.org.uk>
Date: Mon, 22 Aug 2016 05:33:53 -0400
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Hurley <peter@hurleysoftware.com>,
        NeilBrown <neil@brown.name>, Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-Id: <87A6509B-3297-44A1-B1E4-24AA7DAEFB43@holtmann.org>
References: <20160818011445.22726-1-robh@kernel.org> <20160818202900.hyvm4hfxedifuefn@earth> <CAL_Jsq+OfT1AXaEKOgZ4oVfpVZhu=55dYoHTG7D_prpnTqpeOg@mail.gmail.com> <20160819052125.ze5zilppwoe3f2lx@earth> <ACEF800E-8DB3-4345-ADE2-15C99F3659D5@goldelico.com> <20160819120631.5fe2af0d@lxorguk.ukuu.org.uk> <61F43885-BE05-482C-9AD6-B52A2DA166B8@goldelico.com> <20160820142226.6121e76d@lxorguk.ukuu.org.uk> <CC150758-1D16-4BB7-A35B-1A7F4D061C7C@goldelico.com> <20160821180910.51cf919d@lxorguk.ukuu.org.uk> <FF7761E8-377A-43AD-96B2-83BA140E030B@goldelico.com> <20160822100936.19fd809f@lxorguk.ukuu.org.uk>
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alan,

>>> We do, today for bluetooth and other protocols just fine  
>> I think it works (even with user-space HCI daemon) because bluetooth HCI is slow (<300kByte/s).
> 
> We do it for PPP over 3G modem as well. Modern 3G modems pretend to be
> network devices, older ones didn't - and you are correct that in that
> scenario we struggled (it's a lot better since Peter sorted the locking
> out to be efficient).

you have this backwards. Older 3G modems pretended to by Hayes compatible and pretended to be talking PPP. However PPP is terminated in the modem itself. It is not spoken over the 3GPP networks. These are purely IP.

And yes, in theory there was a dialup in GSM, but I don't know of any users. Even early 9600 baud communication was RLP based. And for modern things like LTE it is IP all the way (including voice).

What some modems still do today is pretend they are Ethernet devices. That is faked by the modem as well and mainly for some odd Windows crap. However many modern modems give you the raw IP stream. You just have to ask nicely.

Regards

Marcel

