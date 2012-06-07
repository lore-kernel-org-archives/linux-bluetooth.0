Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120607070339.GA11609@x220>
References: <1339029663-25654-1-git-send-email-andre.guedes@openbossa.org>
	<20120607070339.GA11609@x220>
Date: Thu, 7 Jun 2012 09:13:33 -0400
Message-ID: <CAJdJm_MeLGpgX9PfhaQCZon5Gg9wXFRRWGB8dXqoNx12uJcqZQ@mail.gmail.com>
Subject: Re: [RFC 1/8] gattrib: Fix GAttrib buffer allocation
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Thu, Jun 7, 2012 at 3:03 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> I've applied all patches as they look ok and the behavior can't get
> much more broken than it was previously. I'll also continue testing them
> at the UPF and do/propose additional fixes if necessary.

FWIW I reviewed the patches as well and didn't find any issues (only
minor comments/recommendations on a single patch). We should at some
point run the MTU tests on PTS to make sure they are passing (although
the IOP tests on UPF are usually better).

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
