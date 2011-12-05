Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <F0070FBC0FB3174D8D11444EB2D5B02644008E@DNCE02.ent.ti.com>
References: <1322129290-10767-1-git-send-email-sancane@gmail.com>
	<20111202112957.GC17203@x220.ger.corp.intel.com>
	<CACLukzK1YyqBszGc679Vj-Pf9+M+s+LaBpnd2_+pan8TCwHODA@mail.gmail.com>
	<CAJdJm_P5OU6vqs+-9xL36=1DWVtgzzY1CEPf6rD3Tws5BSik2g@mail.gmail.com>
	<F0070FBC0FB3174D8D11444EB2D5B02643D9D0@DNCE02.ent.ti.com>
	<CAJdJm_PAC_HsEd-8-25r4V-ZqG0gfxpio=rnUZzG4AWJM2cNJQ@mail.gmail.com>
	<F0070FBC0FB3174D8D11444EB2D5B02644008E@DNCE02.ent.ti.com>
Date: Mon, 5 Dec 2011 07:36:37 -0400
Message-ID: <CAJdJm_O0xPVm9D5MOE30t2Baxq7ot5-fWWLvo65gSNOJGf-2dQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Provide return status in gatt_service_add function
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: "Ganir, Chen" <chen.ganir@ti.com>
Cc: Santiago Carot <sancane@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Mon, Dec 5, 2011 at 7:10 AM, Ganir, Chen <chen.ganir@ti.com> wrote:
> What do you mean restoring the attribute handles ? Each of the profiles registers its own services when the plugin is loaded, according to the load order (which I assume will not change).

There is no guarantee in the load order. As we add more plugins, you
can't predict the order the plugins will be loaded.

> When a profile registers its attributes, it can specify callbacks for read/write which are actually function pointers. How to you plan to support this?

Only attribute *handles* are to be stored (for now). The mapping could
be based on service+characteristic UUIDs (but we need to pay attention
if we have multiple services with same service and characteristic
UUIDs; for this case, I'm not even sure how the client knows which one
to use).

> In addition, who will be responsible for reloading the database and populating the values (profile plugin or bluetoothd core) ? how do you synchronize them?

My suggestion would be to implement this in attrib/gatt-service.c so
gatt_service_add() could load attribute handles from storage
transparently. This could also avoid changing every profile.

Note this is only for *server* roles (e.g. PAS server, TIP server, PXP
reporter etc.).

I'm not sure what you mean with synchronization. The attribute handles
are to be stored when the service is registered (and you can't change
them after registration).

> Do you have an RFC or a simple design description which will allow reviewing?

No. I am not working on this currently. This discussion started from
an idea from Santiago to how to handle registration failures (see
initial post), to which I responded that we may want first to address
attribute handle storage to make sure handles stay the same during
device lifetime (until it is factory reset).

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
