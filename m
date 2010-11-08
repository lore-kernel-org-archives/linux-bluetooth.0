Return-Path: <cyrus@holtmann.org>
Date: Mon, 8 Nov 2010 05:22:26 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Stefan Seyfried <stefan.seyfried@googlemail.com>,
	linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org
Subject: Re: bluez-4.78 broken for me
Message-ID: <20101108032226.GA25187@jh-x301>
References: <20101108003042.35493250@susi.home.s3e.de>
 <20101108003740.GA7213@jh-x301>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20101108003740.GA7213@jh-x301>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Nov 08, 2010, Johan Hedberg wrote:
> You really should enable debug logs (-d switch) to get more info about
> which code paths are being traveresed here (since there are many places
> which can cause those log messages). However, my suspicion goes to a
> possible mismatch in the adapter address upon initialization and later
> lookups. Could you try if the attached patch fixes the issue? Thanks.

I was able to reproduce the issue myself. Even though reverting the
patch I mentioned should work as a quick fix I went ahead and pushed a
more proper one to git (it essentially makes hciops wait for the
read_bd_addr complete event before calling start_adapter). So please
test with latest git and let me know if things still work fine. If they
do I think we should release 4.79 since I suspect this race condition
will be experienced by quite many people.

Johan
