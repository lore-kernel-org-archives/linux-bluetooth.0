Return-Path: <kai.heng.feng@canonical.com>
MIME-Version: 1.0
In-Reply-To: <20170913173957.GM16216@wotan.suse.de>
References: <d68738f6-b079-0fef-dd9c-dca75e756c42@gmail.com>
 <CA+55aFzWABZ+KCKT+r+TgyrWfnc+6YE7ZuHhZmgw-cRQXWTQ2w@mail.gmail.com>
 <E31F8274-519A-4ED7-90C0-2BB71C9CC3ED@holtmann.org> <20170911134647.GA3980@kroah.com>
 <20170911171138.GA16216@wotan.suse.de> <20170911192955.GB23729@kroah.com>
 <20170911200651.GB16216@wotan.suse.de> <09F52990-796D-4F19-957B-EEFCA6ADC160@holtmann.org>
 <20170912162729.GC16216@wotan.suse.de> <3A938253-4CB7-4D24-82B1-6A2E3B794077@holtmann.org>
 <20170913173957.GM16216@wotan.suse.de>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Mon, 2 Oct 2017 16:34:11 +0800
Message-ID: <CAAd53p4NEL0XvYjPagYuTjHCJyW5jz20cLsf0GU91KvRax17oQ@mail.gmail.com>
Subject: Re: btusb "firmware request while host is not available" at resume
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Gabriel C <nix.or.die@gmail.com>,
	Tejun Heo <tj@kernel.org>, "Gustavo F. Padovan" <gustavo@padovan.org>,
	Sukumar Ghorai <sukumar.ghorai@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luis,

On Thu, Sep 14, 2017 at 1:39 AM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
[snipped]
> Would a fw_cache_hint(device, name_list) be reasonable then sometime *before*
> suspend? All this would do is ask the firmware API to extend the fw cache
> list with the entries. It would not load firmware immediately, instead this
> would trigger a request for the hinted firmware to become available for
> suspend. Then these drivers could request for firmware at resume and it
> will pick up the cached firmware.

I think I am the author the patch [1] mentioned by Marcel. I have to
admit, it's quite
clunky in it's current form.
So yes, the new API you proposed is definitely better to solve the
issue. I'll send
new patch for btusb once we have the new API to use.

Also, with patch [1], the "firmware request while host is not
available" may still get hit
on some corner cases. I proposed another patch [2] to tackle the edge
case, can you
take a look?

[1] https://lkml.org/lkml/2017/8/25/58
[2] https://lkml.org/lkml/2017/8/22/123

Kai-Heng

>
>   Luis
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
