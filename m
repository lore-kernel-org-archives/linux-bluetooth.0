Return-Path: <cyrus@holtmann.org>
Date: Thu, 26 Apr 2012 16:07:57 -0400 (EDT)
Message-Id: <20120426.160757.1741140873728970494.davem@davemloft.net>
To: mcgrof@do-not-panic.com
Cc: zambrano@broadcom.com, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	arend@broadcom.com, joe@perches.com
Subject: Re: [PATCH] b44: properly use pr_fmt()
From: David Miller <davem@davemloft.net>
In-Reply-To: <CAB=NE6VR6hPqoUmRH=YVr+MKu+Sn8tq2asv957zfD+SVWzk75A@mail.gmail.com>
References: <CAB=NE6WBw3aJrch0JvxZ7jGb_rFW5Z4XWvYc1KqsBqBu+G8mjw@mail.gmail.com>
	<CAB=NE6ViDGHPn=OsqFK1rJb-5J+1xzvf3h9+Rd-MgmWpn-T2fA@mail.gmail.com>
	<CAB=NE6VR6hPqoUmRH=YVr+MKu+Sn8tq2asv957zfD+SVWzk75A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-wireless-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Thu, 26 Apr 2012 08:53:30 -0700

> OK I found no pr_fmt warnings at all for make allmodconfig ; make V=1
> ; on v3.4-rc4. For this and others reason stated then yes, this patch
> is simply bogus.

This is what I expected, thanks for sorting this out :-)

We're in the rally!
