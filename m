Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH BlueZ v2 1/2] plugins: Use open()/read() instead of fopen()/fread() on autopair
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20130520235142.GA14092@x220>
Date: Tue, 21 May 2013 08:10:58 +0200
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Message-Id: <AFBD4A7D-5877-4D24-B5B2-A002288EC878@holtmann.org>
References: <1368721510-14339-1-git-send-email-anderson.lizardo@openbossa.org> <1368801089-30703-1-git-send-email-anderson.lizardo@openbossa.org> <20130520235142.GA14092@x220>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>> +	fd = open("/dev/urandom", O_RDONLY);
>> +	if (fd < 0) {
>> +		ssize_t n;
>> +
>> +		n = read(fd, &seed, sizeof(seed));
>> +		if (n < (ssize_t) sizeof(seed))
>> +			seed = time(NULL);
>> +
>> +		close(fd);
>> +	} else
>> +		seed = time(NULL);
> 
> So, it's not always wise to go blindly copying code examples/suggestions
> from Marcel without thinking a bit. You're checking for invalid fd when
> you should be checking for a valid one (>= 0).

good one.

Having to read this again, can someone please tell when a Linux platform will not have /dev/urandom and we really need to care? Wouldn't it be better to bail out loudly with an error message and do not use any auto pair feature at all.

Regards

Marcel

