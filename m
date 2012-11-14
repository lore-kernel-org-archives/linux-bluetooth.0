Return-Path: <cyrus@holtmann.org>
Message-ID: <1352903987.20338.8.camel@aeonflux>
Subject: Re: [RFC] Bluetooth: Add BT_DEFER_SETUP option to sco socket
From: Marcel Holtmann <marcel@holtmann.org>
To: frederic.dalleau@linux.intel.com
Cc: Michael Knudsen <m.knudsen@samsung.com>,
	linux-bluetooth@vger.kernel.org
Date: Wed, 14 Nov 2012 23:39:47 +0900
In-Reply-To: <50A36E06.2060206@linux.intel.com>
References: <1352830825-13987-1-git-send-email-frederic.dalleau@linux.intel.com>
	 <1352830825-13987-2-git-send-email-frederic.dalleau@linux.intel.com>
	 <50A355CF.4030809@samsung.com> <50A36E06.2060206@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> > My idea is to define (I'm not sure if this is exactly the same as what you
> > suggested yourself) a bit, LM_DEFER, that e.g. sco_connect_ind() may return
> > and propagate this bit to hci_conn_request_evt().  This way all policing of
> > accepting SCO connections is handled from a single entry point into sco.c.
> 
> You detailed it much further than I did, but yes it is the same idea. I 
> fully support it! If everybody agrees, then I can update the patch.
> 
> hci.h would receive the folowing line:
> 
> + #define HCI_LM_DEFER   0x4000

can we actually not that that. This is an old public API and I rather
not extend it.

Regards

Marcel


