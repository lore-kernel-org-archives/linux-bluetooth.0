Return-Path: <cyrus@holtmann.org>
Date: Mon, 22 Aug 2011 11:29:33 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Pavel Raiskup <praiskup@redhat.com>
Cc: linux-bluetooth@vger.kernel.org, ovasik@redhat.com,
	stlman@poczta.fm
Subject: Re: [PATCH 1/8] Off-by-one(two) error in form factor detection
Message-ID: <20110822082933.GD11306@dell>
References: <op.v0avzhpah52hc0@dhcp-25-209.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <op.v0avzhpah52hc0@dhcp-25-209.brq.redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pavel,

On Tue, Aug 16, 2011, Pavel Raiskup wrote:
> Indexing of chassis_map array has to be done like that:
>     chassis_map[chassis_type * 2 - 1]
> 
> because if not, everything is shifted by one. When (e.g.) chassis_type
> is 0x04 result should be "Low Profile Desktop" =>  "desktop" (not a
> "Pizza Box" => "server"). Lets see the 2.6.1 document on:
> 
> http://www.dmtf.org/standards/smbios
> ---
>  plugins/formfactor.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

The patch doesn't apply (probably due to your email client splitting
lines). You might want to consider using git send-email instead:

Applying: Off-by-one(two) error in form factor detection
fatal: corrupt patch at line 10
Patch failed at 0001 Off-by-one(two) error in form factor detection

I also added Łukasz to CC since he sent a patch to this very same line a
month ago or so (and introduced the "+ 1). Łukasz, did you really verify
the correctness of your patch? (it seems you didn't)

Johan
