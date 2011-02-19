Return-Path: <cyrus@holtmann.org>
Date: Sat, 19 Feb 2011 12:18:33 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Brian Gix <bgix@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	anderson.lizardo@openbossa.org
Subject: Re: [PATCH 2/2] Fix bugs found at UPF38 - Las Vegas
Message-ID: <20110219151833.GB18898@jh-x301>
References: <1298072261-7232-1-git-send-email-bgix@codeaurora.org>
 <1298072261-7232-3-git-send-email-bgix@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1298072261-7232-3-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On Fri, Feb 18, 2011, Brian Gix wrote:
> Example Included Service Attribute missing UUID16 field.
> MTU Exchange not bounded by actual size required not to crash.
> ---
>  attrib/example.c    |    3 ++-
>  src/attrib-server.c |    2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)

Even though these are some quite trivial changes, you essentially have
to independent fixes here and they should therefore be in two separate
patches. Also make sure that the summary line of each patch gives at
least some idea of what is being fixed. The way you formulated it now
just tells us that "something" found at UPF38 was fixed.

Johan

P.S. I think you can stop adding extra people to CC in your patch
submissions. --to linux-bluetooth@vger.kernel.org should be enough.
