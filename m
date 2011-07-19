Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] adaptername: Move adapter naming into a plugin
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Date: Tue, 19 Jul 2011 13:35:21 +0100
In-Reply-To: <CABBYNZKCm0F=xLm0QqthhcOjK7e1DgweX2cXLzV6FeMijy2UCw@mail.gmail.com>
References: <BANLkTind9qu33viRE+eSB6b7SiGhr_DTLQ@mail.gmail.com>
	 <1307554688-21555-1-git-send-email-hadess@hadess.net>
	 <20110614080730.GC28890@dell.ger.corp.intel.com>
	 <1308043116.26522.1.camel@air.hadess.net>
	 <20110614094338.GA18317@dell.ger.corp.intel.com>
	 <1308133135.9190.11.camel@air.hadess.net>
	 <20110615210400.GA8352@dell.ger.corp.intel.com>
	 <CABBYNZ+RmdxgAbDSyjHeQj3nYmAMBPCt6jZxNrpbR2o6GOUi4A@mail.gmail.com>
	 <CABBYNZKCm0F=xLm0QqthhcOjK7e1DgweX2cXLzV6FeMijy2UCw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1311078938.3572.5.camel@air.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2011-07-19 at 14:35 +0300, Luiz Augusto von Dentz wrote:
> Hi Bastien,
> 
> On Tue, Jul 19, 2011 at 2:26 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> > Hi Bastien,
> >
> > Apparently there is something wrong when removing last adapter
> > bluetoothd start burning cpu, disabling adaptername fix the problem so
> > there might be something wrong in adapter remove callback, can you
> > take a look? Btw, Im using rawhide so I suppose adaptername should
> > work, right?
> 
> 
> It seems .remove is closing and removing the watch for every adapter
> but the watch is initialized in the plugin init so it is not really
> per-adapter, so I moved to .exit:

You're completely correct here. My mistake.

