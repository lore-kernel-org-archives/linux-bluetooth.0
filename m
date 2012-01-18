Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <F0070FBC0FB3174D8D11444EB2D5B0260B41E0F8@DNCE02.ent.ti.com>
References: <1326842930-31623-1-git-send-email-vinicius.gomes@openbossa.org>
	<F0070FBC0FB3174D8D11444EB2D5B0260B41DE13@DNCE02.ent.ti.com>
	<CAJdJm_OXhZeB-Vx900PR7gwb1A0xiJzgyp6BP9x-hbgE6Gx7Nw@mail.gmail.com>
	<F0070FBC0FB3174D8D11444EB2D5B0260B41E0F8@DNCE02.ent.ti.com>
Date: Wed, 18 Jan 2012 10:51:42 -0400
Message-ID: <CAJdJm_NCs4WtLNggQ6ARLsXqvUcnrDPLiQ+EZ-+8V8DOyL4WPg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 01/11] mgmt-api: Update the commands for exchanging LTK's
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: "Ganir, Chen" <chen.ganir@ti.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Wed, Jan 18, 2012 at 10:41 AM, Ganir, Chen <chen.ganir@ti.com> wrote:
>> Note that BlueZ is still relying on the kernel LE advertising cache
>> (which is refreshed with either the automatic scanning prior to
>> connection, or with the future background scanning support) for
>> detecting address type for non-bonded devices. We have no plans to
>> change that in near feature, because IIRC it would require changing
>> bluetooth socket API (which would break all current BR/EDR
>> applications).
>>
>> This is an issue separate from LTK storage, if you are interested on
>> pursuing this, feel free to make a proposal.
>>
>
> I have a working implementation now that is able to create a connection for bonded devices (currently just bonded devices, but in the future, any created device node) without relying on the scan cache. I simply store the device address, and use it when connecting to that device. I see no reason or possibility for a device to change its address type during its life time (correct me if I'm wrong, and please describe a use case for that).

How do you know which address type to use for LE Create Connection
(Own_Address_Type in page 1073) on the kernel side? AFAIK, there is no
way to differentiate a public address from random just by looking at
the address (the public address has no "reserved" bits). You need the
address type as found on the advertising reports.

What do you mean by "store"? for how long it is stored, specially for
non-bonded devices? Is it on kernel or userspace?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
