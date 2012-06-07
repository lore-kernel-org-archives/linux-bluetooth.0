Return-Path: <cyrus@holtmann.org>
Date: Thu, 7 Jun 2012 23:18:03 +0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] Bluetooth: AMP: Do not set name for AMP ctrl
Message-ID: <20120607151803.GA24609@x220.docomointertouch.net>
References: <1338994856-31200-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20120606152225.GA24903@x220.ccr.corp.intel.com>
 <20120606152736.GA25191@x220.ccr.corp.intel.com>
 <20120607064040.GA32366@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120607064040.GA32366@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Jun 07, 2012, Andrei Emeltchenko wrote:
> > Actually, should we even be exposing AMP controllers to begin with
> > through mgmt? Maybe we shouldn't even tell user space about them through
> > mgmt?
> 
> This seems to be right. BTW: What is the best way to disable mgmt for
> device?
>  - Clear HCI_MGMT flag ?
>  - Do not run mgmt_powered ?
> 
> BTW: Where that flag HCI_MGMT is set and how this check supposed to be
> working?
> 
> test_and_set_bit(HCI_MGMT, &hdev->dev_flags))

The HCI_MGMT flag indicates that there's a mgmt-capable user-space that
is aware of the hci_dev.

The first thing that comes to mind is to add checks to mgmt_index_added,
mgmt_index_removed, mgmt_get_index_list and the place in mgmt_control
that calls hci_dev_get. Since all of these places essentially would need
to do the the same check it might be worth to wrap it into a macro, e.g.
mgmt_valid_hdev().

Johan
