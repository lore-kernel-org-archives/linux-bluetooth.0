Return-Path: <cyrus@holtmann.org>
Date: Sat, 19 Feb 2011 12:14:23 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Brian Gix <bgix@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	anderson.lizardo@openbossa.org
Subject: Re: [PATCH 1/2] Add SDP registration of Primary GATT services
Message-ID: <20110219151423.GA18898@jh-x301>
References: <1298072261-7232-1-git-send-email-bgix@codeaurora.org>
 <1298072261-7232-2-git-send-email-bgix@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1298072261-7232-2-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On Fri, Feb 18, 2011, Brian Gix wrote:
> Add capability to register SDP record for Primary Services.
> ---
>  attrib/example.c    |   24 ++++++++
>  src/attrib-server.c |  157 +++++++++++++++++++++++++++++++++++++++------------
>  src/attrib-server.h |    3 +-
>  3 files changed, 147 insertions(+), 37 deletions(-)

This patch has been pushed upstream. Thanks.

Johan
