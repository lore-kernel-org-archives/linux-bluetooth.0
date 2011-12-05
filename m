Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <F0070FBC0FB3174D8D11444EB2D5B02643D9D0@DNCE02.ent.ti.com>
References: <1322129290-10767-1-git-send-email-sancane@gmail.com>
	<20111202112957.GC17203@x220.ger.corp.intel.com>
	<CACLukzK1YyqBszGc679Vj-Pf9+M+s+LaBpnd2_+pan8TCwHODA@mail.gmail.com>
	<CAJdJm_P5OU6vqs+-9xL36=1DWVtgzzY1CEPf6rD3Tws5BSik2g@mail.gmail.com>
	<F0070FBC0FB3174D8D11444EB2D5B02643D9D0@DNCE02.ent.ti.com>
Date: Mon, 5 Dec 2011 06:55:50 -0400
Message-ID: <CAJdJm_PAC_HsEd-8-25r4V-ZqG0gfxpio=rnUZzG4AWJM2cNJQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Provide return status in gatt_service_add function
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: "Ganir, Chen" <chen.ganir@ti.com>
Cc: Santiago Carot <sancane@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Sun, Dec 4, 2011 at 2:51 AM, Ganir, Chen <chen.ganir@ti.com> wrote:
> How do you ensure that? Do you assume that all servers will always initialize at bluetoothd startup, and always in the same order? Who's responsibility is it to send out the "service changed" notification when something changed? What is the proposed logic for this ?

To make sure the handles do not change between bluetoothd restarts
(and is not dependent on any loading order), we need to save/restore
attribute handles, like is done for other BlueZ parts.

"Service Changed" is not necessary to be sent if attribute handle
storage is implemented. We have no plans to implement "Service
Changed" now, but feel free to send patches :)

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
