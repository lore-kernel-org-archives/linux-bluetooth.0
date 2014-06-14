Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH] Bluetooth: Fix properly ignoring LTKs of unknown types
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20140614082754.GA29342@t440s.P-661HNU-F1>
Date: Sat, 14 Jun 2014 11:20:58 +0200
Cc: Scott James Remnant <keybuk@google.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <BB4D95DB-B9F1-4F89-A67B-F2BC1258E120@holtmann.org>
References: <1401381413-12782-1-git-send-email-johan.hedberg@gmail.com> <CAHZ1yC=AtZu=hiJpfji4+jyb82J806if+VjwtGcYaDuDUqRdHQ@mail.gmail.com> <20140614082754.GA29342@t440s.P-661HNU-F1>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

> That's a good observation (though to be fair it was Marcel and not me
> adding the Cc tags ;)
> 
> Anyway, the primary target of these fixes was 3.16 and 3.15 where I
> believe the dependency is already covered. For earlier stable trees we
> can fix this up by doing a manual patch submission to stable@vger.

exactly, the primary goal is to get 3.16-rcX fixed and all stable tags have the intention to fix 3.15.x. Once that is done, we have to figure out 3.14.x and maybe 3.13.x where we most likely have to manually submit some depending patches.

If I made a mistake with a stable tag for 3.15.x, then please point me to the one where I screwed up. There is a chance that I overlooked something since I was drowning in way to many trees and way too many patches.

Please also keep in mind that only patches that have a commit hash in Linus' tree are suppose to be pushed to the other stable queues. So right now we have to wait for the bluetooth.git pull request to actually make it into Linus' tree first.

Regards

Marcel

