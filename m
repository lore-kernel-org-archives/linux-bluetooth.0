Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Jun 2012 11:30:34 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] Bluetooth: Use %pMR BT addr print spec instead of batostr
Message-ID: <20120615083033.GF7205@aemeltch-MOBL1>
References: <1339419200-581-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20120612031846.GF24440@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120612031846.GF24440@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Tue, Jun 12, 2012 at 12:20:15AM -0300, Gustavo Padovan wrote:
> Hi Andrei,
> 
> * Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-06-11 15:53:20 +0300]:
> 
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > 
> > Clean up old unsafe batostr function and use %pMR print specifier
> > for printing Bluetooth addresses.
> > 
> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > ---
> > 	* Note that the patch shall be only applied when the tree is rebased against
> > 	very latest linux-next where specifier patch is added.
> > <------8<-----------------------------------------------------
> > |
> > |  The patch titled
> > |       Subject: vsprintf: add %pMR for Bluetooth MAC address
> > |  has been added to the -mm tree.  Its filename is
> > |       vsprintf-add-%pmr-for-bluetooth-mac-address.patch
> > |
> > <------8<-----------------------------------------------------
> 
> The patch looks good to me. So please carry this patch on your tree until we
> are able to apply it in bluetooth-next.

OK, Please consider version 2 which I will send in a minute.

Best regards 
Andrei Emeltchenko 

