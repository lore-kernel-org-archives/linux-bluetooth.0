Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 2/3] tools/btpclient: Add connect, disconnect commands
Date: Wed, 10 Jan 2018 14:14:21 +0100
Message-ID: <1937636.eWU8Ucivx0@ix>
In-Reply-To: <20180110122527.GA30141@x1c.lan>
References: <20180109154521.30947-1-grzegorz.kolodziejczyk@codecoup.pl> <2315889.ORn3k3E786@ix> <20180110122527.GA30141@x1c.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wednesday, 10 January 2018 13:25:27 CET Johan Hedberg wrote:
> Hi Szymon,
> 
> On Wed, Jan 10, 2018, Szymon Janc wrote:
> > On Wednesday, 10 January 2018 12:24:56 CET Johan Hedberg wrote:
> > > On Wed, Jan 10, 2018, Szymon Janc wrote:
> > > > On Tuesday, 9 January 2018 16:45:20 CET Grzegorz Kolodziejczyk wrote:
> > > > > +static bool addr2str(const uint8_t *addr, char *str)
> > > > > +{
> > > > > +	return sprintf(str, "%02hhX:%02hhX:%02hhX:%02hhX:%02hhX:%02hhX",
> > > > > +			addr[0], addr[1], addr[2], addr[3], addr[4], addr[5])
> > > > > +			== 17;
> > > > > +}
> > > > 
> > > > Use snprintf.
> > > 
> > > Why isn't this tool using the address conversion helpers from
> > > lib/bluetooth.c?
> > 
> > This is BTP address and has different byte order.
> 
> Hmm... I'm a bit confused now. I thought BTP is little endian like HCI
> and most Bluetooth protocols. At least that's what it says here:
> 
> https://github.com/zephyrproject-rtos/zephyr/blob/master/tests/bluetooth/tes
> ter/btp_spec.txt#L58
> 
> What am I missing? :)

Yes, you're correct. This needs fixing, although we would have to link against 
libbluetooth only for those sprintf wrappers.. (especially that those use 
insecure variant of printf).

-- 
pozdrawiam
Szymon Janc


