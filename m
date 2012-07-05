Return-Path: <cyrus@holtmann.org>
Date: Thu, 05 Jul 2012 18:15:29 -0300 (BRT)
Message-Id: <20120705.181529.1972884390629333855.pcacjr@zytor.com>
To: johan.hedberg@gmail.com
Cc: paulo.alcantara@openbossa.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2 02/12] storage: Store address type in
 "aliases" file
From: Paulo Alcantara <pcacjr@zytor.com>
In-Reply-To: <20120705104141.GA27842@x220.ger.corp.intel.com>
References: <1341347535-15343-1-git-send-email-paulo.alcantara@openbossa.org>
	<1341347535-15343-3-git-send-email-paulo.alcantara@openbossa.org>
	<20120705104141.GA27842@x220.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

From: Johan Hedberg <johan.hedberg@gmail.com>
Date: Thu, 5 Jul 2012 13:41:42 +0300

> This looks dangerous to me. Even though the only users of delete_entry()
> use addresses as the key values there's nothing about the naming of this
> function that suggests that it's only usable for key values with a very
> specific format compared to what the rest of storage.c is designed to
> support (arbitrary key values).

Agreed.

> Either the function name and/or the "key" parameter name needs to be
> changed to make this restricted use clear or then the error handling of
> old keys should be pushed to the caller side (device.c).

Ok. I think we can do something like this too:

int delete_entry(bdaddr_t *src, const char *storage, bdaddr_t *dst,
    			  	      	   	     uint8_t dst_type)
{
	...
	...
}

So, we're going to remove an entry from a given destinate address rather than
from a very specific key format, then we can treat old and new key formats
within it.

What do you think about this ?


		Paulo
