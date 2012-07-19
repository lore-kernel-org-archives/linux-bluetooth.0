Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Jul 2012 17:55:19 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Joao Paulo Rechi Vita <jprvita@openbossa.org>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/2] time: fix byte position
Message-ID: <20120719145519.GA3879@x220.P-661HNU-F1>
References: <1341509854-9875-1-git-send-email-jprvita@openbossa.org>
 <CAJdJm_NjTgwanMe-eSZ6RYQLV1-4V5tetpidr1Qd4aS2P7=XFA@mail.gmail.com>
 <CAAngNMY8vwedEQdxvg2nUn0jqLy0vryPR6iz4Wd0Kwo5d1fHpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAAngNMY8vwedEQdxvg2nUn0jqLy0vryPR6iz4Wd0Kwo5d1fHpw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Jul 10, 2012, Joao Paulo Rechi Vita wrote:
> On Thu, Jul 5, 2012 at 6:39 PM, Anderson Lizardo
> <anderson.lizardo@openbossa.org> wrote:
> > Hi Joao,
> >
> > On Thu, Jul 5, 2012 at 2:37 PM, João Paulo Rechi Vita
> > <jprvita@openbossa.org> wrote:
> >> The position of the "Time Zone" and "Daylight Saving Time" fields on
> >> the Local Time Information characteristic was inverted. This commit
> >> fix their position.
> >> ---
> >>  time/server.c |   10 +++++-----
> >>  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > Patch looks good.
> 
> Is there something preventing this patches to being merged? I see
> Gustavo is already sending the directory move patches, and this will
> probably not apply after his patches.

No particular reason why they weren't applied before the directory
restructuring. Could you please resend them to match the latest tree?

Johan
