Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [V4.1] Regression: Bluetooth mouse not working.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CA+55aFx+NrXEtd4bveFbZqw0r9UHxkrQ7rzdZBbfBiGdvEX3zw@mail.gmail.com>
Date: Fri, 17 Apr 2015 13:35:11 -0700
Cc: =?utf-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <024FA95B-C70F-42ED-BDBF-69D09AA58203@holtmann.org>
References: <CADDKRnBzf+dPqzHxXBWynwssc4su-7LVDCteZCNJJXJEuVca0w@mail.gmail.com> <CA+55aFz3hLbESYbzeMWtyMLbYnCUr-Tx56DA_C=39wxhVGJd6g@mail.gmail.com> <CADDKRnCsTgDfAZ+rbzKvEXh2ut2=sMKBfS7a7YR+5Rxi02557g@mail.gmail.com> <CADDKRnBiB+z2iMc+04ZzntRkGhVW5isNQ+sLt-UVPg3mo+Q7jg@mail.gmail.com> <300602D8-9DB7-4F8D-AC97-B60924554093@holtmann.org> <CADDKRnB0ioBM+EQcNfuk4=BRw=CCxi4aFfZVpSXzJWmBPSNy+g@mail.gmail.com> <38429B86-0E46-4C6A-9954-3260D864B10C@holtmann.org> <CA+55aFx+NrXEtd4bveFbZqw0r9UHxkrQ7rzdZBbfBiGdvEX3zw@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Linus,

>> okay. I only looked at BlueZ 5.x and that might have been my mistake. Let me check this and fix this properly.
> 
> Why not just revert that commit. It looks like garbage. It has odd code like
> 
> +       u32 valid_flags = 0;
> +       ci->flags = session->flags & valid_flags;
> 
> which is basically saying "no flags are valid, and we are silently
> just clearing them all when copying".
> 
> The reason I think it's garbage is
> 
> (a) the commit clearly breaks something, so the whole "let's check
> flags that we've never checked before" is already fundamentally
> suspicious
> 
> (b) code like the above is just crap to begin with, because it makes
> things superficially "look" sensible when looking at individual lines
> of code (for example, when grepping things), and then when you look at
> the actual bigger picture, it turns out that the code doesn't actually
> care about the flags it is "copying", it just clears them all.
> 
> The other code sequences do things like
> 
> +       u32 valid_flags = 0;
> +       if (req->flags & ~valid_flags)
> +               return -EINVAL;
> 
> Which again is just a very unreadable way of saying "if any flags are
> set, return an error". This kind of thing is presumably what breaks
> things, because clearly people *have* set flags that you thought are
> invalid.
> 
> Now *IF* the interfaces had had these kinds of flag validation checks
> from day one, that would be one thing. But adding these kinds of
> things after the fact, when somebody then reports that they break
> things, then that's just a big big flag that you shouldn't try to do
> this at all. It's water under the bridge. That ship has sailed. It's
> too late. Give up on it.
> 
> So I don't think this code is "fixable". It really smells like a
> fundamental mistake to begin with. Just revert it, chalk it up as "ok,
> that was a stupid idea", and move on.

accepting all flags regardless was an oversight on my part in the first place. What this patch tried to do is to limit it to what userspace is currently actually using. My mistake was to look only at BlueZ 5.x userspace and not at BlueZ 4.x userspace. The fix to not break existing userspace is essentially this:

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index a05b9dbf14c9..9070dfd6b4ad 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -1313,7 +1313,8 @@ int hidp_connection_add(struct hidp_connadd_req *req,
                        struct socket *ctrl_sock,
                        struct socket *intr_sock)
 {
-       u32 valid_flags = 0;
+       u32 valid_flags = BIT(HIDP_VIRTUAL_CABLE_UNPLUG) |
+                         BIT(HIDP_BOOT_PROTOCOL_MODE);

I ask Joerg to test this patch, but looking at old userspace is that is what is happening there.

Regards

Marcel

