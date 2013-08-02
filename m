Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CANT-zCU9HFLUB0=ooxJHGeRXQLvbfTHnjPaQnmJ7adMSN6icqQ@mail.gmail.com>
References: <1373626483-2031-1-git-send-email-mikel.astiz.oss@gmail.com>
	<CABBYNZLkVCNiqKpF=EsW+1uS4pK6mnvt26XzKEbFinQfGdLVyQ@mail.gmail.com>
	<CANT-zCU9HFLUB0=ooxJHGeRXQLvbfTHnjPaQnmJ7adMSN6icqQ@mail.gmail.com>
Date: Fri, 2 Aug 2013 17:18:50 +0300
Message-ID: <CABBYNZKS5o+FuRch0pi3iiCUwdL9OdNPv=YXNXWbjLXWGiuwRw@mail.gmail.com>
Subject: Re: [RFC BlueZ v0 00/10] HSP plugin
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Fri, Jul 12, 2013 at 4:48 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> Besides the issues pointed out by Luiz, which I could fix in a next
> proposal, can you give your opinion on this approach?
>
> It makes little sense to try to advance in this direction if it
> doesn't fit the project plan.
>
> Johan also suggested that such a feature could be automatically
> disabled when an external profile (oFono) registers.

So as some know the initial idea was reject due to the use of Media
API which is now supposed to be A2DP specific, so Im currently
discussing with PulseAudio folks where this should be done then, so
far we come up with 3 options:

1. External profile implemented inside PA
2. BlueZ plugin with a different API
3. Dedicated daemon

I guess 1 or 2 is preferable as 3 might be overkill to maintain
independently, for solution 2 probably the API would be very similar
to the one implemented by oFono for HFP.


-- 
Luiz Augusto von Dentz
