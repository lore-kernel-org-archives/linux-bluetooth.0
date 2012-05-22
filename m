Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 May 2012 14:08:35 -0300 (BRT)
Message-Id: <20120522.140835.1272290193958501225.pcacjr@zytor.com>
To: johan.hedberg@gmail.com
Cc: paulo.alcantara@openbossa.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2 1/2] storage: Store BLE address type in
 "primary" file
From: Paulo Alcantara <pcacjr@zytor.com>
In-Reply-To: <20120522080536.GB9688@x220>
References: <1337633316-4992-1-git-send-email-paulo.alcantara@openbossa.org>
	<1337633316-4992-2-git-send-email-paulo.alcantara@openbossa.org>
	<20120522080536.GB9688@x220>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

From: Johan Hedberg <johan.hedberg@gmail.com>
Date: Tue, 22 May 2012 11:05:36 +0300

> > +	/* New format: address#type */
> > +	ba2str(dba, key);
> > +	sprintf(&key[17], "#%hhu", bdaddr_type);
> 
> Since BlueZ 4.100 will be the first user space version being able to use
> mgmtops with a kernel where mgmt is enabled by default (3.4) I don't
> think we need to worry about old format vs new format, i.e. the code
> comment above is unnecessary.

Ok. When we were implemeting this, our first thought was to just ignore the old
storage formats and then use the new storage one.

So, later we decided to keep backward compatibily with the old storage format
since one might not want to delete his old entries so that the patch wouldn't
work with this new storage format (the old keys would never be found).

I'll remove the comment above. Thanks for pointing it out.

> 
> > +	/* New format: address#type */
> > +	ba2str(dba, key);
> > +	sprintf(&key[17], "#%hhu", bdaddr_type);
> > +
> > +	str = textfile_caseget(filename, key);
> > +	if (str != NULL)
> > +		return str;
> > +
> > +	/* Old format: address only */
> > +	key[17] = '\0';
> > +
> > +	return textfile_caseget(filename, key);
> 
> Same thing here. I think we can leave out any code that tries to work
> with the old storage format since we can consider LE support as
> experimental/unstable in all previous user space releases.

Fair enough. I'll remove the comment above, as well the code that leads with the
old storage format. Thanks again!


		Paulo
