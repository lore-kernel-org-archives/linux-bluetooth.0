Return-Path: <cyrus@holtmann.org>
Date: Fri, 21 Jan 2011 12:20:29 +0530
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Brian Gix <bgix@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, vinicius.gomes@openbossa.org,
	claudio.takahasi@openbossa.org, padovan@profusion.mobi
Subject: Re: [PATCH] Fix incoming attrib-server connection MTUs
Message-ID: <20110121065029.GB1789@jh-x301>
References: <1295550541-30535-1-git-send-email-bgix@codeaurora.org>
 <1295550541-30535-2-git-send-email-bgix@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1295550541-30535-2-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On Thu, Jan 20, 2011, Brian Gix wrote:
> It is important for the Attribute Server to be aware of and completely
> fill response packets up to the full MTU when reading long attributes.
> Some remote devices will only request additional (READ_BLOB) data if
> the preceding read sent the maximum amount of data.
> 
> Incoming connections are identified as L2CAP or LE by pointers to the
> Service IO channel the incoming connection was recieved on in the
> user_data parameter. L2CAP channels are set to the BR/EDR minimum MTU
> of 48, and LE channels to the LE payload size of 23.
> ---
>  attrib/att.h        |    3 ++-
>  attrib/gatt.c       |   28 ++++++++++++++--------------
>  src/attrib-server.c |   13 +++++++++----
>  3 files changed, 25 insertions(+), 19 deletions(-)

Thanks for the updated patch. It looks good now and has been pushed
upstream.

Johan
