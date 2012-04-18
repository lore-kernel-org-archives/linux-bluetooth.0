Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <F0070FBC0FB3174D8D11444EB2D5B0260B4836F1@DNCE05.ent.ti.com>
References: <F0070FBC0FB3174D8D11444EB2D5B0260B4836F1@DNCE05.ent.ti.com>
Date: Wed, 18 Apr 2012 23:51:12 +0300
Message-ID: <CABBYNZK3bVZF-EWcP5MWANVc-e7j_8j2YKpUTZ28edCu6d6QeA@mail.gmail.com>
Subject: Re: Device discovery procedure
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Ganir, Chen" <chen.ganir@ti.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Wed, Apr 18, 2012 at 3:15 PM, Ganir, Chen <chen.ganir@ti.com> wrote:
> All,
>
> I've looked into the adapter.c code, after I encountered a little problem. It seems that for some reason, in adapter.c, in function void adapter_set_discovering(...), which is called by mgmt_discovering(...) as a result of discovering state change, we take a decision to start a timer for rescheduling the discovery process again. This relies on the main_opts.discov_interval, and it calls the following code to start the timer:
>
>        adapter->discov_id = g_timeout_add_seconds(main_opts.discov_interval, discovery_cb, adapter);
>
> If the main_opts.discov_interval is equal to 0, this means that the discovery procedure will restart immediately, and loop forever until someone explicitly stops the discovery.

The implementation has changed a little bit with introduction of mgmt,
before it used to tell the time window where used for doing name
resolving between, thus setting it 0 would disable name resolving.

Now main_opts.discov_interval doesn't control name resolving anymore,
the names will continue to be resolved until all discovered devices
have their names resolved (skipping the ones that for some reason
failed).

So there is a little behavior changing in the sense that each
discovery round is no longer deterministic, it will go on until all
names are resolved, and so with main_opts.discov_interval you can only
add a delay to before starting a next discovery which perhaps is not
that useful.

> Is this intentional? Is this how it's supposed to work ? Is there a way to disable this behavior?

Looping forever is intentional, has been for a while actually, what
doesn't seems to be intentional is removing the possibility to disable
name resolving by setting the interval to 0, actually our default
should probably be 0 now not 30 seconds since during all this time we
gonna be idle.

-- 
Luiz Augusto von Dentz
