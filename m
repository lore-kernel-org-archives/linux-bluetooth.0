Return-Path: <cyrus@holtmann.org>
Date: Mon, 21 May 2012 17:52:47 -0300 (BRT)
Message-Id: <20120521.175247.1388227604292700355.pcacjr@zytor.com>
To: johan.hedberg@gmail.com
Cc: paulo.alcantara@openbossa.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/2] storage: Store BLE address type in "primary"
 file
From: Paulo Alcantara <pcacjr@zytor.com>
In-Reply-To: <20120519064124.GA27057@x220.P-661HNU-F1>
References: <1337374667-17802-1-git-send-email-paulo.alcantara@openbossa.org>
	<1337374667-17802-2-git-send-email-paulo.alcantara@openbossa.org>
	<20120519064124.GA27057@x220.P-661HNU-F1>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

From: Johan Hedberg <johan.hedberg@gmail.com>
Date: Sat, 19 May 2012 09:41:24 +0300

> > +	/* New format: address#type */
> > +	ba2str(dba, key);
> > +	key[17] = '#';
> > +	key[18] = ba_type2char(bdaddr_type);
> 
> Wouldn't sprintf(&key[17], "#%hhu", bdaddr_type); be much simpler?

Agreed. Fixed it.

> > +	/* New format: address#type */
> > +	ba2str(dba, key);
> > +	key[17] = '#';
> > +	key[18] = ba_type2char(bdaddr_type);
> 
> Same here.

Fixed it too.


		Paulo
