Return-Path: <cyrus@holtmann.org>
Date: Mon, 27 Sep 2010 17:49:30 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Ville Tervo <ville.tervo@nokia.com>
Cc: "ext johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Hedberg Johan (Nokia-MS/Helsinki)" <Johan.Hedberg@nokia.com>
Subject: Re: [PATCH] Bluetooth: Don't clear the blacklist when closing the
 HCI device
Message-ID: <20100927204930.GF5489@vigoh>
References: <1284017559-13510-1-git-send-email-johan.hedberg@gmail.com>
 <20100915094909.GB14330@null>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100915094909.GB14330@null>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* Ville Tervo <ville.tervo@nokia.com> [2010-09-15 12:49:09 +0300]:

> On Thu, Sep 09, 2010 at 09:32:39AM +0200, ext johan.hedberg@gmail.com wrote:
> > From: Johan Hedberg <johan.hedberg@nokia.com>
> > 
> > Clearing the blacklist in hci_dev_do_close() would mean that user space
> > needs to do extra work to re-block devices after a DEVDOWN-DEVUP cycle.
> > This patch removes the clearing of the blacklist in this case and
> > thereby saves user space from the extra work.
> > 
> > Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
> 
> Acked-by: Ville Tervo <ville.tervo@nokia.com>

Patch has been applied to my bluetooth-next-2.6 tree to later merge in 
wireless-next-2.6

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
