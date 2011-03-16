Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Mar 2011 07:53:57 +0200
From: Ville Tervo <ville.tervo@nokia.com>
To: ext Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: ext Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFC v2 0/6] LE advertising cache
Message-ID: <20110316055357.GG4369@null>
References: <1299850377-3734-1-git-send-email-andre.guedes@openbossa.org>
 <20110315075742.GD4369@null>
 <AANLkTikK4vjMgpuBHMLP4-6J2JMMnWqbaDo1-rwFsjEY@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <AANLkTikK4vjMgpuBHMLP4-6J2JMMnWqbaDo1-rwFsjEY@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Mar 15, 2011 at 10:41:55AM -0400, ext Anderson Lizardo wrote:
> Hi Ville,
> 
> On Tue, Mar 15, 2011 at 3:57 AM, Ville Tervo <ville.tervo@nokia.com> wrote:
> > Hi,
> >
> > On Fri, Mar 11, 2011 at 10:32:51AM -0300, ext Andre Guedes wrote:
> >> During a LE connection establishment, the host should be able to infer the
> >> bdaddr type from a given bdaddr.
> >>
> >> To achieve that, during the LE scanning, the host stores the bdaddr and the
> >> bdaddr type gathered from advertising reports. The host keeps a list of
> >> advertising entry (bdaddr and bdaddr_type) for later lookup. This list will
> >> be called Advertising Cache.
> >>
> >> Since the penality to connect to an unreachable device is relatively high,
> >> we must keep only fresh advertising entries on the advertising cache. So,
> >> before each LE scanning the advertising cache is cleared. Also, after the LE
> >> scanning, a timer is set to clear the cache.
> >
> > I tested these pathes with a device which had random address. Connection works
> > which is good.
> >
> > How ever I'm not yet sure if mandatory scanning before every connect is
> > acceptable.
> 
> IIRC the connection procedure defined on the spec requires this scan.
> See for instance the general connection establishment procedure at
> page 1715

But it makes "Direct Connection Establishment" impossible.

Is it needed to pass PTS for example?

> 
> >
> > I have been playing with idea to derive address type from msb bits of the
> > address. Any ideaѕ what would lose in that way?
> 
> How can you differ public address type from a random one in this case?
> I think the MSB bit checking is only for detecting the type of random
> address (static, non-resolvable private, resolvable private)

That's true. Address type needs to be known.


-- 
Ville
