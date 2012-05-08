Return-Path: <cyrus@holtmann.org>
Date: Tue, 8 May 2012 10:57:26 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>,
	Mat Martineau <mathewm@codeaurora.org>,
	linux-bluetooth@vger.kernel.org, pkrystad@codeaurora.org
Subject: Re: [PATCHv2 2/2] Bluetooth: Lock the L2CAP channel when sending
Message-ID: <20120508075724.GB29352@aemeltch-MOBL1>
References: <1336166431-4926-1-git-send-email-mathewm@codeaurora.org>
 <1336166431-4926-3-git-send-email-mathewm@codeaurora.org>
 <20120505000104.GB23728@joana>
 <20120508074223.GA29352@aemeltch-MOBL1>
 <20120508074451.GA19057@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120508074451.GA19057@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Tue, May 08, 2012 at 04:44:51AM -0300, Gustavo Padovan wrote:
> > > >  include/net/bluetooth/bluetooth.h |    2 --
> > > >  net/bluetooth/l2cap_sock.c        |   19 +++++++++++--------
> > > >  2 files changed, 11 insertions(+), 10 deletions(-)
> > > 
> > > Patch has been applied to the bluetooth tree. Thanks.
> > 
> > What about applying the first patch? I actually pulled that patch from
> > bluetooth-next and modified locking in my code but now that patch seems to
> > be lost.
> 
> I applied it to bluetooth.git. Now you have to wait we merge bluetooth.git
> into bluetooth-next.git, that will happen shortly after John pull the pull
> request I sent.

Should this be other way around? First we apply to testing and then to
stable?

Best regards 
Andrei Emeltchenko 

