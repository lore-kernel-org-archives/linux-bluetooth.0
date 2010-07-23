Return-Path: <cyrus@holtmann.org>
Date: Fri, 23 Jul 2010 15:01:15 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: =?iso-8859-1?Q?Jos=E9?= Antonio Santos Cadenas
	<santoscadenas@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Santiago Carot-Nemesio <scarot@libresoft.es>,
	Santiago Carot-Nemesio <sancane@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 16/60] Implement function to send md_reconnect_mdl_req
Message-ID: <20100723180115.GK2620@vigoh>
References: <1279788733-2324-10-git-send-email-sancane@gmail.com>
 <20100723095813.GA17429@jh-x301>
 <AANLkTikCYPQ-e45YeUa4KCBAnfdX2Eofjq0YuVQMwpxL@mail.gmail.com>
 <201007231244.42402.santoscadenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <201007231244.42402.santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi José,

* José Antonio Santos Cadenas <santoscadenas@gmail.com> [2010-07-23 12:44:42 +0200]:

> Hi,
> 
> El Friday 23 July 2010 12:31:03 Luiz Augusto von Dentz escribió:
> > Hi,
> > 
> > On Fri, Jul 23, 2010 at 12:58 PM, Johan Hedberg <johan.hedberg@gmail.com> 
> wrote:
> > > The SDP code in libbluetooth is probably the absolute worst place to
> > > look for good examples. In this case the second variable in the function
> > > is completely unnecessary. Just assign the malloc return directly to the
> > > mcap_md_req pointer and get rid of the uint8_t* variable.
> > > 
> > > Btw, I'd like to understand why we should use different acceptance
> > > criteria for your patches compared to everything else that gets
> > > submitted to BlueZ. The convention (which I'm sure you've noticed if you
> > > follow the list) is that when issues are found in submitted patches the
> > > submitter is requested to fix the issue in the patch and resubmit a new
> > > version of the patch. You're essentially requesting for buggy patches to
> > > be accepted as such and only fix the issues through new patches on top
> > > of the buggy ones.
> > 
> > I completely agree with this, one of the reason for this convention is
> > that we don't want this changes split apart because they probably
> > cannot be reverted individually. Another point is the history will be
> > completely disorganized if we start to accept those fixes separately,
> > it worth mention that this can eventually happen with patches already
> > upstream, but then it is normally a regression fix and as such we
> > normally mention the original commit which has caused it. I would
> > understand if we were in the old days of cvs, but with git it is
> > pretty simple to rearrange the changes, just use git rebase -i + git
> > reset or whatever other form to get this fixed in place.
> 
> We agree with you two. This is the complete development history that we have 
> now. We sent it like this because we understood that keeping the history will 
> be better. We don't care sending a different history with all the bug 
> corrections amended.

You can keep the history and at same time do all the fixes in the
patches and amend them. That's not too hard.

> 
> About the use of git rebase, it is not the first time that we do this and 
> because of this we know that rebase some commits will make some of the 
> following commits not compile. It will be a long and hard work to fix this, so 
> it will be better and easier to create a new "virtual" history that splits the 
> whole implementation in smaller patches.


-- 
Gustavo F. Padovan
http://padovan.org
