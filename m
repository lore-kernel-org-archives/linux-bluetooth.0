Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120426.160757.1741140873728970494.davem@davemloft.net>
References: <CAB=NE6WBw3aJrch0JvxZ7jGb_rFW5Z4XWvYc1KqsBqBu+G8mjw@mail.gmail.com>
 <CAB=NE6ViDGHPn=OsqFK1rJb-5J+1xzvf3h9+Rd-MgmWpn-T2fA@mail.gmail.com>
 <CAB=NE6VR6hPqoUmRH=YVr+MKu+Sn8tq2asv957zfD+SVWzk75A@mail.gmail.com> <20120426.160757.1741140873728970494.davem@davemloft.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Thu, 26 Apr 2012 13:30:50 -0700
Message-ID: <CAB=NE6X18E3YtfS=Xzw7oxCHNQGC07Kq6ZhXkiUE3S-DAjNqbg@mail.gmail.com>
Subject: Re: [PATCH] b44: properly use pr_fmt()
To: David Miller <davem@davemloft.net>
Cc: zambrano@broadcom.com, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	arend@broadcom.com, joe@perches.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-wireless-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Apr 26, 2012 at 1:07 PM, David Miller <davem@davemloft.net> wrote:
> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
> Date: Thu, 26 Apr 2012 08:53:30 -0700
>
>> OK I found no pr_fmt warnings at all for make allmodconfig ; make V=1
>> ; on v3.4-rc4. For this and others reason stated then yes, this patch
>> is simply bogus.
>
> This is what I expected, thanks for sorting this out :-)

Thanks for kicking me in the balls.

> We're in the rally!

This is the highlight of my life (8:17) !

  Luis
