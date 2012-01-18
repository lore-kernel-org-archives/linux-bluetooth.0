Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <F0070FBC0FB3174D8D11444EB2D5B0260B41DE13@DNCE02.ent.ti.com>
References: <1326842930-31623-1-git-send-email-vinicius.gomes@openbossa.org>
	<F0070FBC0FB3174D8D11444EB2D5B0260B41DE13@DNCE02.ent.ti.com>
Date: Wed, 18 Jan 2012 06:40:42 -0400
Message-ID: <CAJdJm_OXhZeB-Vx900PR7gwb1A0xiJzgyp6BP9x-hbgE6Gx7Nw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 01/11] mgmt-api: Update the commands for exchanging LTK's
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: "Ganir, Chen" <chen.ganir@ti.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Wed, Jan 18, 2012 at 3:17 AM, Ganir, Chen <chen.ganir@ti.com> wrote:
> Storing the address type in the LTK is not perfect. For this to work properly, you will store the address type only for devices which exchanged keys. What if we have devices which do not do pairing or exchange keys at all ? What if we use the CreateDevice instead of CreatePairedDevice? In that case we will not have the address type for future reconnections. We need to store the device address type in a separate file (for example, addresstypes) and manage it separately from the LTK management.

Note that BlueZ is still relying on the kernel LE advertising cache
(which is refreshed with either the automatic scanning prior to
connection, or with the future background scanning support) for
detecting address type for non-bonded devices. We have no plans to
change that in near feature, because IIRC it would require changing
bluetooth socket API (which would break all current BR/EDR
applications).

This is an issue separate from LTK storage, if you are interested on
pursuing this, feel free to make a proposal.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
