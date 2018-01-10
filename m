Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 10 Jan 2018 13:24:56 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 2/3] tools/btpclient: Add connect, disconnect
 commands
Message-ID: <20180110112456.GA25998@x1c.lan>
References: <20180109154521.30947-1-grzegorz.kolodziejczyk@codecoup.pl>
 <20180109154521.30947-2-grzegorz.kolodziejczyk@codecoup.pl>
 <2527986.brPqJesFBN@ix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2527986.brPqJesFBN@ix>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Jan 10, 2018, Szymon Janc wrote:
> On Tuesday, 9 January 2018 16:45:20 CET Grzegorz Kolodziejczyk wrote:
> > +static bool addr2str(const uint8_t *addr, char *str)
> > +{
> > +	return sprintf(str, "%02hhX:%02hhX:%02hhX:%02hhX:%02hhX:%02hhX",
> > +			addr[0], addr[1], addr[2], addr[3], addr[4], addr[5])
> > +			== 17;
> > +}
> 
> Use snprintf.

Why isn't this tool using the address conversion helpers from
lib/bluetooth.c?

Johan
