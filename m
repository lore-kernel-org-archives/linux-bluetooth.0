Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] android/avrcp: Decouple AVRCP logic from btio
Date: Tue, 11 Feb 2014 15:37:12 +0100
Message-ID: <5637916.N4zjDhQ0cI@leonov>
In-Reply-To: <20140211130306.GG8980@aemeltch-MOBL1>
References: <1391702774-18972-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <20140211130306.GG8980@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tuesday 11 of February 2014 15:03:07 Andrei Emeltchenko wrote:
> Hi All
> 
> On Thu, Feb 06, 2014 at 06:06:11PM +0200, Andrei Emeltchenko wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > 
> > The patch makes AVRCP to be channel-agnostic so that it might be used in
> > unit tests. The idea is that all AVRCP logic would come to avrcp-lib and
> > channel stuff got to avrcp.
> 
> Any comments regarding this patch?

Waiting for V2 as discussed offline.

-- 
BR
Szymon Janc
