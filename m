Return-Path: <cyrus@holtmann.org>
Date: Fri, 12 Aug 2011 10:55:44 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] doc: add org.bluez.Handsfree interface
Message-ID: <20110812135543.GA4168@joana>
References: <1313155680-10759-1-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1313155680-10759-1-git-send-email-frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Frédéric Danis <frederic.danis@linux.intel.com> [2011-08-12 15:28:00 +0200]:

> This change allows to share the same interface for both Handsfree HF
> and AG (only diffrence is interface name), and most part of the code.
> 
> This will imply to rename and update audio/gateway.[ch] to be more hfp
> generic (moving it to audio/hfp.[ch], renaming APIs from gateway_...()
> to hfp_...()).

what will be the future of the current implementation of the HFP Audio Gateway
implementation in BlueZ. Will it be  deprecated?

	Gustavo
