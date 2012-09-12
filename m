Return-Path: <cyrus@holtmann.org>
Date: Wed, 12 Sep 2012 11:45:37 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Chen Ganir <chen.ganir@ti.com>
Cc: Joao Paulo Rechi Vita <jprvita@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 02/10] battery: Implement Generic device battery
Message-ID: <20120912084537.GA31700@x220.P-661HNU-F1>
References: <1347349100-24228-1-git-send-email-chen.ganir@ti.com>
 <1347349100-24228-3-git-send-email-chen.ganir@ti.com>
 <CAAngNMbUQzxAdwo2JUjzrqkLGXFhpyRVqtz03u+3t3nfXcyxpg@mail.gmail.com>
 <50501416.90408@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <50501416.90408@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Wed, Sep 12, 2012, Chen Ganir wrote:
> >Since this symbol is being exported, shouldn't it be prefixed with
> >btd_ as well?
> >
> I will rename it to struct btd_battery. Is that ok ?

Yes.

> 
> >>+typedef void (*RefreshBattFunc) (struct device_battery *batt);
> >
> >I don't think we use CamelCase for anything other than D-Bus method names.
> >
> We use it in gattrib.h for function pointers. What is the correct
> convention for function pointers ? same as in adapter_ops ?
> 
> >>+
> >>+typedef enum {
> >>+       BATTERY_OPT_INVALID = 0,
> >>+       BATTERY_OPT_LEVEL,
> >>+       BATTERY_OPT_REFRESH_FUNC,
> >>+} BatteryOption;
> >
> >Fix CamelCase usage here and on uses of this type as well.
> >
> btio.h also uses this convention. What should be the correct convention ?

Both BtIO and GAttrib intend to mimic GLib-like libraries where this is
the convention. The plan is not to let this spread to the entire code
base (particularly with the likely move to libell in the long run), so
please don't use CamelCase.

Johan
