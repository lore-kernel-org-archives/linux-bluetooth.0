Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Fri, 4 Nov 2011 19:38:02 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/4] Add option 'Y' to set socket priority for
 l2test
Message-ID: <20111104213802.GA29013@joana>
References: <1320333340-27112-1-git-send-email-luiz.dentz@gmail.com>
 <1320439678.15441.285.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1320439678.15441.285.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

* Marcel Holtmann <marcel@holtmann.org> [2011-11-04 21:47:57 +0100]:

> Hi Luiz,
> 
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > 
> > Priority is set using SO_PRIORITY, see man 7 socket for more details.
> 
> why are we using the letter 'Y'?

Probably because we are running out of letters in l2test, almost of them are
already taken.

	Gustavo
