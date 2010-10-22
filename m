Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Fri, 22 Oct 2010 11:58:59 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Yuri Ershov <ext-yuri.ershov@nokia.com>
Cc: marcel@holtmann.org, davem@davemloft.net, jprvita@profusion.mobi,
	linux-bluetooth@vger.kernel.org, ville.tervo@nokia.com,
	andrei.emeltchenko@nokia.com
Subject: Re: [PATCH] bluetooth: Fix NULL pointer dereference issue
Message-ID: <20101022135859.GA15476@vigoh>
References: <1987fd374e92ea2e4ebb06b24c6321e65ab933c6.1287676475.git.ext-yuri.ershov@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1987fd374e92ea2e4ebb06b24c6321e65ab933c6.1287676475.git.ext-yuri.ershov@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Yuri,

* Yuri Ershov <ext-yuri.ershov@nokia.com> [2010-10-21 20:08:58 +0400]:

> This patch fixes NULL pointer dereference at running test with
> connect-transfer-disconnect in loop. Sometimes sk_state is 
> BT_CLOSED and sk_refcnt equal to 0, so there is oops in 
> bt_accept_unlink. In normal case removed block is not used.

Question here is: Why sk_refcnt is 0 at that point of the code?  The
socket should be destroyed if it ref is 0, but it wasn't, so something
in another point of the code went is wrong. "Sometimes" is not a good
description of the problem, you have to show why that happened.

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
