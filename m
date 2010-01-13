Return-Path: <cyrus@holtmann.org>
Date: Wed, 13 Jan 2010 09:35:39 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Zhu Yanhai <yanhai.zhu@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Don't pass down NULL path to dbus if no modem.
Message-ID: <20100113073539.GA18361@jh-x301>
References: <1263276935-7456-1-git-send-email-yanhai.zhu@linux.intel.com>
 <20100113062819.GA16896@jh-x301>
 <4B4D6DC3.2020407@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4B4D6DC3.2020407@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jan 13, 2010, Zhu Yanhai wrote:
> > 2. Leaking modem_obj_path if it was already set
> 
> I think it will be freed in telephony_exit().

The point was that if you fetch the modems list more than once or if
there's more than one modem the previous value of modem_obj_path will be
overwritten with a new one without freeing the original string first.

Johan
