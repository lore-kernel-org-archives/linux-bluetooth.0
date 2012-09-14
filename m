Return-Path: <cyrus@holtmann.org>
Date: Fri, 14 Sep 2012 12:56:18 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
Subject: Re: [PATCHv4 07/17] Bluetooth: AMP: Remote AMP ctrl definitions
Message-ID: <20120914095617.GE7483@aemeltch-MOBL1>
References: <alpine.DEB.2.02.1209111121550.3754@mathewm-linux>
 <1347437192-24694-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1347437192-24694-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <alpine.DEB.2.02.1209130846560.19321@mathewm-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1209130846560.19321@mathewm-linux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Thu, Sep 13, 2012 at 08:50:24AM -0700, Mat Martineau wrote:

...

> >+struct amp_ctrl {
> >+	struct list_head	list;
> >+	struct kref		kref;
> >+	__u8			id;
> >+	__u16			assoc_len_so_far;
> >+	__u16			assoc_rem_len;
> >+	__u16			assoc_len;
> >+	__u8			*assoc;
> >+};
> 
> I think you have the necessary information here.  There should be no
> need to also track the remote device in the amp_ctrl struct because
> the amp_mgr that owns the list of controllers is only referring to
> one remote device, right?

amp_mgr tracks the list of remote AMP controllers found in the A2MP
Discover Response. It is not limited to one remote controller.

Though it is usually only one AMP controller but Spec says that:

<------8<-------------------------------------------------------------------------
|  Controller List (3 or more octets)
|  Controller List is variable in length. It consists of 1 or more entry.
|  Each entry is comprised of a Controller ID, a Controller Type and a Controller
|  status.
<------8<-------------------------------------------------------------------------

Then for each controller we send A2MP Getinfo Request.

Best regards 
Andrei Emeltchenko 
