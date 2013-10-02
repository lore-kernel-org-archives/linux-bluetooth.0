Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 Oct 2013 09:39:39 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Bluetooth: Use only 2 bits for controller type
 information
Message-ID: <20131002063939.GA28911@x220.p-661hnu-f1>
References: <1380514261-21742-1-git-send-email-marcel@holtmann.org>
 <20130930181632.GB26405@x220.p-661hnu-f1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130930181632.GB26405@x220.p-661hnu-f1>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Sep 30, 2013, Johan Hedberg wrote:
> On Sun, Sep 29, 2013, Marcel Holtmann wrote:
> > The controller type is limited to BR/EDR/LE and AMP controllers. This
> > can be easily encoded with just 2 bits and still leave enough room
> > for future controller types.
> > 
> > Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> > ---
> >  net/bluetooth/hci_core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Acked-by: Johan Hedberg <johan.hedberg@intel.com>

All three patches in this set have been applied to bluetooth-next.

Johan
