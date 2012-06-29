Return-Path: <cyrus@holtmann.org>
Date: Fri, 29 Jun 2012 14:54:02 +0200
From: "Dalleau, Frederic" <frederic.dalleau@intel.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Dalleau
	<frederic.dalleau@linux.intel.com>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] network: Reply to extensions at connection setup
Message-ID: <20120629125402.GB12649@intel.com>
References: <1338470470-6874-1-git-send-email-frederic.dalleau@linux.intel.com>
 <20120629111454.GB19540@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20120629111454.GB19540@x220>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

O Fri, Jun 29, 2012 at 1:14 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> What was the conclusion for this patch? Should it be applied to user
> space upstream or was there some decision to only handle this on the
> kernel side?
>
> Johan

>From my understanding, Marcel said it could be a first step, because it will
be necessary for compatibility anyway if we want to add the Net filter and
multicast filter. I have sent a patch for review to add ioctl to handle these
features in kernel, but a change in userspace will still be necessary to use
them.

However, I suggest you wait until next week, I should get confirmation whether
this is ok for qualification or not.

BR,
Frédéric
