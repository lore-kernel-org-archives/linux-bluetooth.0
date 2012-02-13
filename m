Return-Path: <cyrus@holtmann.org>
Message-ID: <1329129670.28848.64.camel@aeonflux>
Subject: RE: LMP transaction collision at Set encryption
From: Marcel Holtmann <marcel@holtmann.org>
To: "Mohanan, Rajmohan" <rajmohan.mohanan@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"padovan@profusion.mobi" <padovan@profusion.mobi>
Date: Mon, 13 Feb 2012 11:41:10 +0100
In-Reply-To: <E74476E55D15D942BA0FF3CDAD73606F041FB8@FMSMSX102.amr.corp.intel.com>
References: <E74476E55D15D942BA0FF3CDAD73606F041AE2@FMSMSX102.amr.corp.intel.com>
	 <1329118089.28848.60.camel@aeonflux>
	 <E74476E55D15D942BA0FF3CDAD73606F041FB8@FMSMSX102.amr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rajmohan,

>                       I'm attaching Patch for LMP transaction collision.
> I could not Create patch according to Latest Bluez Tree because due to Project Constraints. Please review the patch . I have added Hcidump  aslo.

please use git format-patch and then git send-email. If you have
problems with Exchange, then just point it to linux.intel.com and it
will work smoothly.

Reviewing attached patches is not something we do here. All patches need
to be inline.

Regards

Marcel


