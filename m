Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Subject: Re: l2cap sockets not properly multiplexed on ARM
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <D9B9EB3A112B8F489DFFA00A6D5C0FE203241DC5@AD-BR-EX-2.adroot.flemingc.local>
Date: Thu, 31 Oct 2013 15:41:49 +0100
Cc: Alexander Holler <holler@ahsoftware.de>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <29BC3449-4F89-4A05-84A5-514EF89A568E@holtmann.org>
References: <D9B9EB3A112B8F489DFFA00A6D5C0FE20324078F@AD-BR-EX-2.adroot.flemingc.local> <5270EC62.6070705@ahsoftware.de>,<5270F19A.4030408@ahsoftware.de> <D9B9EB3A112B8F489DFFA00A6D5C0FE2032408B0@AD-BR-EX-2.adroot.flemingc.local>,<527114A4.5010207@ahsoftware.de> <D9B9EB3A112B8F489DFFA00A6D5C0FE2032419A8@AD-BR-EX-2.adroot.flemingc.local> <4A213FF7-48BA-4906-8868-7C3A227EF954@holtmann.org>,<527190DA.6000805@ahsoftware.de> <D9B9EB3A112B8F489DFFA00A6D5C0FE203241BE2@AD-BR-EX-2.adroot.flemingc.local>,<F9B30CD6-4DCB-4F58-9322-E18969867664@holtmann.org> <D9B9EB3A112B8F489DFFA00A6D5C0FE203241DC5@AD-BR-EX-2.adroot.flemingc.local>
To: Tim Tisdall <tim.tisdall@flemingcollege.ca>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tim,

>> I actually need to know if bluetooth-next tree still has this issue. That is first and foremost the one thing that needs to be checked.
> 
> I really doubt it's an issue with bluetooth-next as it's only been an issue with kernel versions 3.4.X and older.
> 
> I'm not familiar with how kernel development goes, so I'm not sure I completely understand what "bluetooth-next" entails.  Aren't there different maintainers for the different major versions of the kernel and don't they update the in-built modules where ever possible?  Is "bluetooth-next" tied to a particular kernel version or does it support a range of versions as it's a module?

bluetooth-next is what will become kernel 3.13 at some point when Linus releases it. It is code that is on its way towards official Linux trees.

If bluetooth-next works as expected, then you could just git bisect and root cause the patch that fixed it. However first you have to establish if bluetooth-next kernel works or not.

Regards

Marcel

