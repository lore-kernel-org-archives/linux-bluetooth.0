Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Jul 2015 13:14:42 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Dean Jenkins <Dean_Jenkins@mentor.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
	Joshua_Frkuska@mentor.com
Subject: Re: [PATCH v2 0/8] Avoid L2CAP ERTM shutdown hung tasks
Message-ID: <20150709101442.GA22988@t440s.lan>
References: <1435078779-4436-1-git-send-email-Dean_Jenkins@mentor.com>
 <8070DCD7-709D-4B34-BD44-12D68DD71E21@holtmann.org>
 <20150709093626.GA19545@t440s.ger.corp.intel.com>
 <559E45C2.70406@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <559E45C2.70406@mentor.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dean,

On Thu, Jul 09, 2015, Dean Jenkins wrote:
> Please can you point to me to some details on how to use the l2cap-tester
> tool so that I can attempt to look into this issue.

First of all, please avoid top-posting on this list.

Regarding l2cap-tester, there's really nothing special needed except for
the hci_vhci module and running the tool as root. However, as I pointed
out what was causing this you shouldn't even need l2cap-tester, but just
create an L2CAP socket with any tool. The more important thing is to
have the right config options in the kernel. I've got at least the
following:

CONFIG_LOCKDEP_SUPPORT=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_PROVE_LOCKING=y
CONFIG_LOCKDEP=y
CONFIG_DEBUG_MUTEXES=y

I'd guess only the "LOCKDEP" ones are really needed, but not completely
sure about it.

I was kind of half expecting you to already be familiar with
l2cap-tester since you were submitting patches to L2CAP, but I guess
it's never too late :) Either way it'd be good if you could also look
into adding new test cases to the tool that specifically exercise the
code paths that you were fixing.

Johan
