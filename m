Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1460480430.2507.17.camel@perches.com>
Subject: Re: [PATCH v2] Bluetooth: Deinline large functions
From: Joe Perches <joe@perches.com>
To: Denys Vlasenko <dvlasenk@redhat.com>,
	Johan Hedberg <johan.hedberg@intel.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 12 Apr 2016 10:00:30 -0700
In-Reply-To: <570D22DD.2010109@redhat.com>
References: <1460399665-19626-1-git-send-email-dvlasenk@redhat.com>
	 <1460433018.2507.1.camel@perches.com> <570D1D9A.6030808@redhat.com>
	 <1460477690.2507.5.camel@perches.com> <570D22DD.2010109@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2016-04-12 at 18:31 +0200, Denys Vlasenko wrote:
> The lowest power device with BT I have is a smartphone,
> a Samsung S5 mini with quad-core 1.4 GHz Exynos 3 CPU.
> It will be 2 years old soon.
> This is what passes for "low power devices" these days.

That's not at all true.  For instance:
http://www.nxp.com/documents/data_sheet/QN902X.pdf

I did call out heart rate monitors and bicycle computers
but unfortunately neglected to mention dive watches.
