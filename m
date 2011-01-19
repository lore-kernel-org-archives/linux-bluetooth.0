Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 Jan 2011 14:29:42 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org, ville.tervo@nokia.com
Subject: Re: [PATCH 4/5] Bluetooth: Fix authentication request for L2CAP
 raw sockets
Message-ID: <20110119162942.GB11083@joana>
References: <1295419012-25717-1-git-send-email-johan.hedberg@gmail.com>
 <1295419012-25717-5-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1295419012-25717-5-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* johan.hedberg@gmail.com <johan.hedberg@gmail.com> [2011-01-19 12:06:51 +0530]:

> From: Johan Hedberg <johan.hedberg@nokia.com>
> 
> When there is an existing connection l2cap_check_security needs to be
> called to ensure that the security level of the new socket is fulfilled.
> Normally l2cap_do_start takes care of this, but that function doesn't
> get called for SOCK_RAW type sockets. This patch adds the necessary
> l2cap_check_security call to the appropriate branch in l2cap_do_connect.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>

I applied patches 1 to 4. Patch 5 doesn't apply to bluetooth-2.6. Please
rebase it. Thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
