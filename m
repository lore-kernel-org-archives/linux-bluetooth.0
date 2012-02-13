Return-Path: <cyrus@holtmann.org>
Message-ID: <1329118089.28848.60.camel@aeonflux>
Subject: RE: LMP transaction collision at Set encryption
From: Marcel Holtmann <marcel@holtmann.org>
To: "Mohanan, Rajmohan" <rajmohan.mohanan@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"padovan@profusion.mobi" <padovan@profusion.mobi>
Date: Mon, 13 Feb 2012 08:28:09 +0100
In-Reply-To: <E74476E55D15D942BA0FF3CDAD73606F041AE2@FMSMSX102.amr.corp.intel.com>
References: <E74476E55D15D942BA0FF3CDAD73606F041AE2@FMSMSX102.amr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rajmohan,

<snip>

> I'm attaching patch for above two issues.
> 
> Please review it and  let me know the feedback.

please send one patch per email. That is what git format-patch and git
send-email are for.

The commit message needs to have a clear explanation of the issue and
how you are fixing it. Including hcidump log is a good idea as well in
these cases where you have some protocol issues.

Patches need to be signed-off-by and should not contain change-id (that
is Android Gerrit stuff).

Also patches need to be against the latest bluetooth-next tree.

Userspace patches should not contain signed-off-by and also no change-id
here as well.

The need to be against latest upstream and #if hacking is not allowed of
course.

Regards

Marcel


