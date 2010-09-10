Return-Path: <cyrus@holtmann.org>
From: "Zhang, Zhenhua" <zhenhua.zhang@intel.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Fri, 10 Sep 2010 08:11:35 +0800
Subject: RE: [PATCH 3/4] btio: Remove unused bt_io_set function
Message-ID: <33AB447FBD802F4E932063B962385B352A6B4AB7@shsmsx501.ccr.corp.intel.com>
References: <1284025283-3773-1-git-send-email-zhenhua.zhang@intel.com>
 <1284025283-3773-4-git-send-email-zhenhua.zhang@intel.com>
 <20100909101901.GA16324@jh-x301>
In-Reply-To: <20100909101901.GA16324@jh-x301>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

Johan Hedberg wrote:
> Hi,
> 
> On Thu, Sep 09, 2010, Zhenhua Zhang wrote:
>> It is not used by either obex or bluez.
>> ---
>>  btio/btio.c |   33 ---------------------------------  btio/btio.h |
>>  3 --- 2 files changed, 0 insertions(+), 36 deletions(-)
> 
> I don't think removing this feature is a good idea. Even though there
> aren't any current users of bt_io_set doesn't mean that there
> wont be in
> the future. I remember e.g. discussions regarding AMP about
> applications needing the ability to request a switch from BR/EDR to
> WLAN for an active connection. This could e.g. be accomplished
> through a setsockopt call. Other uses for setsockopt while a
> connection is open, or even changing settings for an existing server
> socket might exist too. 
> 
> Johan

That's fine for me. I don't see any current function call so I have this patch. I will resend them and remove patch 3/4. Let me know if you have other suggestiosn.

Regards,
Zhenhua

