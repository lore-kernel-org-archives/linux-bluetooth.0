Return-Path: <cyrus@holtmann.org>
Date: Mon, 27 Oct 2014 15:10:03 +0100
From: Alexander Aring <alex.aring@gmail.com>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 2/3] Bluetooth: 6lowpan: Fix lockdep splats
Message-ID: <20141027141000.GB24691@omega>
References: <1414418683-1057-1-git-send-email-jukka.rissanen@linux.intel.com>
 <1414418683-1057-3-git-send-email-jukka.rissanen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1414418683-1057-3-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jukka,

On Mon, Oct 27, 2014 at 04:04:42PM +0200, Jukka Rissanen wrote:
> When a device ndo_start_xmit() calls again dev_queue_xmit(),
> lockdep can complain because dev_queue_xmit() is re-entered and the
> spinlocks protecting tx queues share a common lockdep class.
> 
> Same issue was fixed for ieee802162 in commit "20e7c4e80dcd"
> 

s/ieee802162/ieee802154/


I know it's hard. I also do some mistake on these IEEE number word
salads.

- Alex
