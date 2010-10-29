Return-Path: <cyrus@holtmann.org>
Date: Fri, 29 Oct 2010 21:45:43 +0100
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Ville Tervo <ville.tervo@nokia.com>,
	Anderson Briglia <anderson.briglia@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: Re: [PATCH 3/6] Bluetooth: Implement the first SMP commands
Message-ID: <20101029204543.GA14961@vigoh>
References: <linux-bluetooth@vger.kernel.org>
 <1287791820-22693-4-git-send-email-anderson.briglia@openbossa.org>
 <20101025130356.GA8862@vigoh>
 <20101026092623.GC15050@null>
 <AANLkTikVG-gjd1d7T6ETbfXCU0jp2GsR0miWJFO55hps@mail.gmail.com>
 <20101028091733.GB15997@vigoh>
 <AANLkTiny4xmZ3KBSvUCrpmQacD8m7dCRQymeJkc_hrDb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTiny4xmZ3KBSvUCrpmQacD8m7dCRQymeJkc_hrDb@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

* Anderson Lizardo <anderson.lizardo@openbossa.org> [2010-10-29 16:28:32 -0400]:

> On Thu, Oct 28, 2010 at 5:17 AM, Gustavo F. Padovan
> <padovan@profusion.mobi> wrote:
> > Yep, we may need a new smp.c file.
> 
> It seems that to support multiple C files, there should not be a .c
> file with the same basename as the final module. This means we would
> need to rename l2cap.c to something else.
> 
> Gustavo, I remember you had some patches to split l2cap.c... Do you
> still intend to apply them? If so, having a separate "smp.c" file will
> be much easier.

Yes, but I still have to discuss one part of the patch with Marcel.

> 
> For now, in our branch we renamed "l2cap.c" to "l2cap_core.c" and
> added the following to net/bluetooth/Makefile:

I'm fine with it, that would done anyway in the future.

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
