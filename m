Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100723095813.GA17429@jh-x301>
References: <1279788733-2324-10-git-send-email-sancane@gmail.com>
	<1279788733-2324-11-git-send-email-sancane@gmail.com>
	<1279788733-2324-12-git-send-email-sancane@gmail.com>
	<1279788733-2324-13-git-send-email-sancane@gmail.com>
	<1279788733-2324-14-git-send-email-sancane@gmail.com>
	<1279788733-2324-15-git-send-email-sancane@gmail.com>
	<1279788733-2324-16-git-send-email-sancane@gmail.com>
	<1279788733-2324-17-git-send-email-sancane@gmail.com>
	<20100722234724.GE2620@vigoh>
	<4C49658D.4090906@libresoft.es>
	<20100723095813.GA17429@jh-x301>
Date: Fri, 23 Jul 2010 13:31:03 +0300
Message-ID: <AANLkTikCYPQ-e45YeUa4KCBAnfdX2Eofjq0YuVQMwpxL@mail.gmail.com>
Subject: Re: [PATCH 16/60] Implement function to send md_reconnect_mdl_req
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Santiago Carot-Nemesio <scarot@libresoft.es>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Santiago Carot-Nemesio <sancane@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Jul 23, 2010 at 12:58 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> The SDP code in libbluetooth is probably the absolute worst place to
> look for good examples. In this case the second variable in the function
> is completely unnecessary. Just assign the malloc return directly to the
> mcap_md_req pointer and get rid of the uint8_t* variable.
>
> Btw, I'd like to understand why we should use different acceptance
> criteria for your patches compared to everything else that gets
> submitted to BlueZ. The convention (which I'm sure you've noticed if you
> follow the list) is that when issues are found in submitted patches the
> submitter is requested to fix the issue in the patch and resubmit a new
> version of the patch. You're essentially requesting for buggy patches to
> be accepted as such and only fix the issues through new patches on top
> of the buggy ones.

I completely agree with this, one of the reason for this convention is
that we don't want this changes split apart because they probably
cannot be reverted individually. Another point is the history will be
completely disorganized if we start to accept those fixes separately,
it worth mention that this can eventually happen with patches already
upstream, but then it is normally a regression fix and as such we
normally mention the original commit which has caused it. I would
understand if we were in the old days of cvs, but with git it is
pretty simple to rearrange the changes, just use git rebase -i + git
reset or whatever other form to get this fixed in place.

-- 
Luiz Augusto von Dentz
Computer Engineer
