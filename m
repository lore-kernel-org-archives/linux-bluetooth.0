Return-Path: <cyrus@holtmann.org>
Date: Fri, 7 Oct 2011 16:57:03 +0300
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 4/4] Bluetooth: convert role_switch variable to flag in
 l2cap chan
Message-ID: <20111007135656.GB30817@aemeltch-MOBL1>
References: <1316181222-32634-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1316181222-32634-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20111006182342.GH5652@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111006182342.GH5652@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Thu, Oct 06, 2011 at 03:23:43PM -0300, Gustavo Padovan wrote:
> > role_switch variable inside l2cap_chan is a logical one and can
> > be easily converted to flag
> > ---
> >  include/net/bluetooth/l2cap.h |    2 +-
> >  net/bluetooth/l2cap_core.c    |    4 ++--
> >  net/bluetooth/l2cap_sock.c    |   12 ++++++++----
> >  3 files changed, 11 insertions(+), 7 deletions(-)
> 
> These four patches can came first. Please rebase them.

Those 4 patches rebased and sent alone. I am also thinking about sending
EWS patches before EFS.

Best regards 
Andrei Emeltchenko 
