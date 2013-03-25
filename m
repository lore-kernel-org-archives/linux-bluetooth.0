Return-Path: <cyrus@holtmann.org>
Date: Mon, 25 Mar 2013 14:27:15 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jefferson Delfes <jefferson.delfes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] gatttool: fix parameter type/name from le to psm
Message-ID: <20130325122715.GA21794@x220.ger.corp.intel.com>
References: <1362429775-19101-1-git-send-email-jefferson.delfes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1362429775-19101-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jefferson,

On Mon, Mar 04, 2013, Jefferson Delfes wrote:
> The parameter le was changed to psm and its type was modified from
> boolean to int, but header was unmodified. That change occurred in commit
> 0cc24599637ed6666469c68d55f4e42ff722e447.
> ---
>  attrib/gatttool.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

Johan
