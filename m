Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Sep 2013 15:57:58 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Nedim Hadzic <nhadzic@blackberry.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [Bluetooth Low Energy] Pairing and writing characteristic
 property issue
Message-ID: <20130913125758.GA29830@x220.p-661hnu-f1>
References: <285F7E29A611CC4197B552ED66CC20B8CE7EBA@XMB102ADS.rim.net>
 <285F7E29A611CC4197B552ED66CC20B8CE898C@XMB102ADS.rim.net>
 <CABBYNZ+smnsbiFhVB1XY50Ffm_d10TYPP2j4Ru+UBnonyjjk8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZ+smnsbiFhVB1XY50Ffm_d10TYPP2j4Ru+UBnonyjjk8g@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Sep 13, 2013, Luiz Augusto von Dentz wrote:
> > This device is using random device address, but I do not know how to
> > pair with it in that case. I try to pair with it using a smartphone
> > with support and it is working. Any help, or input on this?
> 
> I believe we don't support pairing with devices using random/private,
> but you should probably upgrade if you are planning to use Bluetooth
> LE BlueZ 5.x is recommended.

In general we don't really support any LE related stuff with BlueZ 4
simply because LE pairing requires the mgmt interface and it wasn't
stable yet during BlueZ 4 times.

Regarding pairing with random addressed devices, BlueZ 5 will allow that
but only for a single connection. Once you disconnect the pairing info
is gone since it'd anyway be unusable if the remote side changed its
address. Until we get IRK generation support for the kernel this is how
user space will keep behaving.

Johan
