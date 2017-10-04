Return-Path: <mcgrof@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171004002038.GC5659@wotan.suse.de>
References: <E31F8274-519A-4ED7-90C0-2BB71C9CC3ED@holtmann.org>
 <20170911134647.GA3980@kroah.com> <20170911171138.GA16216@wotan.suse.de>
 <20170911192955.GB23729@kroah.com> <20170911200651.GB16216@wotan.suse.de>
 <09F52990-796D-4F19-957B-EEFCA6ADC160@holtmann.org> <20170912162729.GC16216@wotan.suse.de>
 <3A938253-4CB7-4D24-82B1-6A2E3B794077@holtmann.org> <20170913173957.GM16216@wotan.suse.de>
 <CAAd53p4NEL0XvYjPagYuTjHCJyW5jz20cLsf0GU91KvRax17oQ@mail.gmail.com> <20171004002038.GC5659@wotan.suse.de>
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Date: Tue, 3 Oct 2017 18:21:17 -0700
Message-ID: <CAB=NE6WEg_FFNxpyDYPj4Bc1wmuDxHv+x5vrpZX1R+Bgx5GExA@mail.gmail.com>
Subject: Re: btusb "firmware request while host is not available" at resume
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Torvalds <torvalds@linux-foundation.org>,
	Gabriel C <nix.or.die@gmail.com>, Tejun Heo <tj@kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>, Sukumar Ghorai <sukumar.ghorai@intel.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Oct 3, 2017 at 5:20 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> the ordering devised currently there is:
>
>   o device driver pm ops called
>   o notifier for suspend issued - *going to suspend*
>   o userspace frozen
>   o filesystem freeze
>
> On the way back up this order is inverted:
>
>   o filesystem freeze
>   o userspace frozen
>   o notifier for suspend issued - *going to suspend*
>   o device driver pm ops called

Fortunately I had it a tad bit wrong, but in a good way. Our ordering
on our way down is:

 o notifier for suspend issued - *going to suspend*
 o userspace frozen
 o filesystem freeze (new, being proposed)
 o device driver pm ops called

Then on our way up:

  o device driver pm ops called
  o filesystem thaw
  o userspace thaw
  o notifier for resume issued - *thawing*

So the driver callbacks get called *later*, so anything called in
notifiers do get a chance to quiesce things properly.

  Luis
