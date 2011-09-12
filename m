Return-Path: <cyrus@holtmann.org>
Subject: RE: [PATCH bluetooth-next] Added force_acl_master param for
 bluetooth module
From: Marcel Holtmann <marcel@holtmann.org>
To: "Ilia, Kolominsky" <iliak@ti.com>
Cc: "ilia.kolominsky@gmail.com" <ilia.kolominsky@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 12 Sep 2011 16:11:14 +0200
In-Reply-To: <AC090B9732AB2B4DB7FF476E907FE66001321E6C14@dnce02.ent.ti.com>
References: <1315798377-3660-1-git-send-email-iliak@ti.com>
	 <1315819740.1937.17.camel@aeonflux>
	 <AC090B9732AB2B4DB7FF476E907FE66001321E6C14@dnce02.ent.ti.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1315836675.1937.20.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ilia,

> > > This param allows role switch request while accepting a new acl
> > > connection. This is an enhancement to l2cap L2CAP_LM role switching
> > > capability which allows requesting role switch without modification
> > > to the application code. It was observed that operating as a master
> > > of piconet (as oposed to scatternet config) is beneficial when
> > > qos (flow_spec) guarantees are requested.
> > 
> > <snip>
> > 
> > >  module_param(enable_le, bool, 0444);
> > >  MODULE_PARM_DESC(enable_le, "Enable LE support");
> > > +module_param(force_acl_master, bool, 0644);
> > > +MODULE_PARM_DESC(force_acl_master, "Always try to switch to master
> > role on ACL link");
> > 
> > using kernel module parameters is not an acceptable API/ABI for this.
> It is not API/ABI, it is a way to configure a system without modifying
> application code and it’s as useful as the other Bluetooth module
> params.

no, we use kernel parameters to on purpose not enable features that have
not passed qualification yet. We do not use it for general purpose
configuration.

And btw. what is wrong with the setting lm to master via hciconfig? That
said, I am pretty much against general purpose setting that are not
really bound to any specific service/profile. The sum of profiles should
define a proper policy and not some magic global setting. Otherwise you
easily run into dead-lock scenarios.

Regards

Marcel


