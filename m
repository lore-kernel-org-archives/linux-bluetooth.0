Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1460477690.2507.5.camel@perches.com>
Subject: Re: [PATCH v2] Bluetooth: Deinline large functions
From: Joe Perches <joe@perches.com>
To: Denys Vlasenko <dvlasenk@redhat.com>,
	Johan Hedberg <johan.hedberg@intel.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 12 Apr 2016 09:14:50 -0700
In-Reply-To: <570D1D9A.6030808@redhat.com>
References: <1460399665-19626-1-git-send-email-dvlasenk@redhat.com>
	 <1460433018.2507.1.camel@perches.com> <570D1D9A.6030808@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2016-04-12 at 18:08 +0200, Denys Vlasenko wrote:
> On 04/12/2016 05:50 AM, Joe Perches wrote:
> > 
> > On Mon, 2016-04-11 at 20:34 +0200, Denys Vlasenko wrote:
> > > 
> > > Fastest existing Bluetooth standard's top speed is 2.4 MB/s.
> > > It is way off from being CPU limited, no need to squeeze
> > > last few cycles by excessive inlining.
> > > 
> > > Size reduction is about 40k:
> > > 
> > >     text     data      bss       dec     hex filename
> > > 95943139 20860256 35991552 152794947 91b7743 vmlinux_before
> > > 95903714 20860256 35991552 152755522 91add42 vmlinux
> > defconfig?
> In defconfig, CONFIG_BT is not set, so there will be no change

Which is why I set it in the defconfig size I sent.

Also, you haven't responded at all to any performance decrease
by uninline for low power/low frequency SOC embedded uses.
