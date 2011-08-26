Return-Path: <cyrus@holtmann.org>
Date: Fri, 26 Aug 2011 16:06:56 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 00/12] Support for the new mgmt SMP messages
Message-ID: <20110826190656.GB18683@samus.indt.org>
References: <1313799128-8842-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1313799128-8842-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 21:11 Fri 19 Aug, Vinicius Costa Gomes wrote:
> Hi,
> 
> This patch series is the userspace side of the changes that introduced
> the specific messages for communicating SMP keys.
> 

As the Blacklisting events patches were applied first to the kernel,
there are a few conflicting types between those series. So if this 
series is to be applied I need to send a new version that solve those 
conflicts (already done, but I don't want to spam the list even more ;-)


Cheers,
-- 
Vinicius
