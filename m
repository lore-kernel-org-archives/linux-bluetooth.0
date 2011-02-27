Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Sun, 27 Feb 2011 17:13:58 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Feng Tang <feng.tang@intel.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: l2cap: fix a NULL pointer oops in
 l2cap_conn_start
Message-ID: <20110227201357.GF2166@joana>
References: <1298361804-11733-1-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1298361804-11733-1-git-send-email-feng.tang@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Feng,

* Feng Tang <feng.tang@intel.com> [2011-02-22 16:03:24 +0800]:

> When I try to setup a PAND connection between the sever and client,
> the server side always get a NULL pointer oops in l2cap_conn_start()
> right after the client run "pand -r PANU -c sever_addr". Don't have
> the boot log as it's an immediate hang.
> 
> Simply adding this "if (parent)" check will fix it, don't know whether
> it fix the real problem. Anyway, send it as a hint.

I pushed a proper fix for this issues, see the bluetooth-2.6 tree.

-- 
Gustavo F. Padovan
http://profusion.mobi
