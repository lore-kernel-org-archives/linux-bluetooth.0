Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <ext.szymon.janc@tieto.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: =?utf-8?B?xYF1a2Fzeg==?= Rymanowski
	<lukasz.rymanowski@codecoup.pl>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 2/2] core/device: Don't set MTU when acting as a peripheral
Date: Thu, 10 Mar 2016 10:42:05 +0100
Message-ID: <4446282.74ti4cqF2s@leonov>
In-Reply-To: <CABBYNZKNkEFO7uAsH55Un47esqezPV-acTiqE1NFMfNXFWKj2Q@mail.gmail.com>
References: <1457094267-5925-1-git-send-email-luiz.dentz@gmail.com> <CAExxLLD+Z4rVRhXqU0MYFKTvOeq09_=-C55fWF9oXdY=mUowTA@mail.gmail.com> <CABBYNZKNkEFO7uAsH55Un47esqezPV-acTiqE1NFMfNXFWKj2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thursday 10 of March 2016 11:35:23 Luiz Augusto von Dentz wrote:
> Hi Lukasz,
> 
> On Thu, Mar 10, 2016 at 11:17 AM, Łukasz Rymanowski
> 
> <lukasz.rymanowski@codecoup.pl> wrote:
> >> Not only we cannot be configured as server, but even if we do the
> >> roles are only relevant for PTS because otherwise there is no way to
> >> tell the roles of the remote device.
> > 
> > If device sends request that means it is a Client. If not that means
> > it is a Server.
> 
> Well if it send it can be a Client/Server as well, btw some systems
> including Android appear to have support to send Exchange MTU at any
> point so detecting a server only pretty hard, besides our current
> design split Server and Client functionality so waiting to see if
> anything has been received before starting sending anything is not so
> trivial and we had still to choose an arbitrary timeout to wait for
> detecting the role but if both are based on BlueZ this would just
> delay each other.

Maybe we could simply delay MTU exchange until we are done with discovery?
For discovery we shouldn't need larger MTU. And if in the meantime remote
initiates MTU exchange we can skip MTU exchange from our side.

-- 
BR
Szymon Janc
