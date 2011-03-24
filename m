Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: =?iso-8859-1?q?Andr=E9_Dieb?= <andre.dieb@signove.com>
Subject: Re: [PATCH 1/5] Inline ATT dump functions
Date: Thu, 24 Mar 2011 12:11:07 +0100
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
References: <1300891601-11412-1-git-send-email-andre.dieb@signove.com> <20110324092452.GE30621@jh-x301> <AANLkTikPc1ejpG5vvpRYk-AmPHtYXJe-GgQuj7-5vr3=@mail.gmail.com>
In-Reply-To: <AANLkTikPc1ejpG5vvpRYk-AmPHtYXJe-GgQuj7-5vr3=@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201103241211.07592.szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> No, I don't. This patch is merely because all hcidump parsers (hci,
> l2cap, etc) are done inline.
> 
> On Thu, Mar 24, 2011 at 6:24 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> > Hi André,
> >
> > On Wed, Mar 23, 2011, Andre Dieb Martins wrote:
> >> ---
> >>  parser/att.c |   32 ++++++++++++++++----------------
> >>  1 files changed, 16 insertions(+), 16 deletions(-)
> >
> > Do you have some measurements that show that inlining actually has a
> > noticable effect? You're also missing the justification for this change
> > in the commit message.

Personally I think that we should have most (if not all) of static functions
uninlined and leave inlining decision to compiler (i.e. -finline-functions)

Inlining functions based on "strong feelings and experience" or "function
is short" without proper profiling this is just pure guesswork and can easily
lead to unwanted results.

-- 
BR
Szymon Janc
