Return-Path: <kai.heng.feng@canonical.com>
MIME-Version: 1.0
In-Reply-To: <20171004002038.GC5659@wotan.suse.de>
References: <E31F8274-519A-4ED7-90C0-2BB71C9CC3ED@holtmann.org>
 <20170911134647.GA3980@kroah.com> <20170911171138.GA16216@wotan.suse.de>
 <20170911192955.GB23729@kroah.com> <20170911200651.GB16216@wotan.suse.de>
 <09F52990-796D-4F19-957B-EEFCA6ADC160@holtmann.org> <20170912162729.GC16216@wotan.suse.de>
 <3A938253-4CB7-4D24-82B1-6A2E3B794077@holtmann.org> <20170913173957.GM16216@wotan.suse.de>
 <CAAd53p4NEL0XvYjPagYuTjHCJyW5jz20cLsf0GU91KvRax17oQ@mail.gmail.com> <20171004002038.GC5659@wotan.suse.de>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Fri, 6 Oct 2017 12:42:34 +0800
Message-ID: <CAAd53p6aqQPtHGrY9bspNYNh5dBfc8MF-5H38tt+dR1LGAropg@mail.gmail.com>
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

On Wed, Oct 4, 2017 at 8:20 AM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> So please retest now that the revert happened: commit
> f007cad159e99fa2acd3b2e9364fbb32ad28b971 ("Revert "firmware: add sanity check
> on shutdown/suspend").

I can confirm the issue is gone after the commit.
Also, thanks for your detailed explanation.


Kai-Heng

>
>   Luis
