Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1460433018.2507.1.camel@perches.com>
Subject: Re: [PATCH v2] Bluetooth: Deinline large functions
From: Joe Perches <joe@perches.com>
To: Denys Vlasenko <dvlasenk@redhat.com>,
	Johan Hedberg <johan.hedberg@intel.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 11 Apr 2016 20:50:18 -0700
In-Reply-To: <1460399665-19626-1-git-send-email-dvlasenk@redhat.com>
References: <1460399665-19626-1-git-send-email-dvlasenk@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2016-04-11 at 20:34 +0200, Denys Vlasenko wrote:
> Fastest existing Bluetooth standard's top speed is 2.4 MB/s.
> It is way off from being CPU limited, no need to squeeze
> last few cycles by excessive inlining.

defconfig?


Size reduction is about 40k:
> 
>     text     data      bss       dec     hex filename
> 95943139 20860256 35991552 152794947 91b7743 vmlinux_before
> 95903714 20860256 35991552 152755522 91add42 vmlinux
> 

