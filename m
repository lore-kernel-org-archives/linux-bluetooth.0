Return-Path: <cyrus@holtmann.org>
Date: Fri, 8 Jul 2011 18:31:55 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 10/12] Bluetooth: Add support for communicating keys
 with userspace
Message-ID: <20110708213155.GA16143@piper>
References: <1310075985-15489-1-git-send-email-vinicius.gomes@openbossa.org>
 <1310075985-15489-10-git-send-email-vinicius.gomes@openbossa.org>
 <20110708203929.GE21343@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110708203929.GE21343@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 17:39 Fri 08 Jul, Gustavo Padovan wrote:
> * Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2011-07-07 18:59:43 -0300]:
> 
> > As the key format has changed to something that has a dynamic size,
> > the way that keys are received and sent must be changed.
> > 
> > The structure fields order is changed to make the parsing of the
> > information received from the Management Interface easier.
> > 
> > Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> > ---
> >  net/bluetooth/mgmt.c |   60 +++++++++++++++++++++++++++++++++++++------------
> >  1 files changed, 45 insertions(+), 15 deletions(-)
> 
> 
> Applied from 1 to 9. this one doesn't apply. Please rebase and resend. Thanks.

Great, thanks. The remaining 3 patches are already on their way to the list.

> 
> 	Gustavo

Cheers,
-- 
Vinicius
