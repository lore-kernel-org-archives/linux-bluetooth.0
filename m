Return-Path: <cyrus@holtmann.org>
Date: Mon, 16 Sep 2013 12:54:53 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 5/8] Bluetooth: Fix error code for invalid CID in
 l2cap_config_req
Message-ID: <20130916095453.GA18200@x220.p-661hnu-f1>
References: <1379179711-16436-1-git-send-email-johan.hedberg@gmail.com>
 <1379179711-16436-6-git-send-email-johan.hedberg@gmail.com>
 <DDB6D220-2DB5-49B3-9200-4AD8FBAAADDE@holtmann.org>
 <20130915063017.GA22996@x220.p-661hnu-f1>
 <D242F6F2-162B-4904-8637-78BA01BF5737@holtmann.org>
 <20130915181552.GA6383@x220.p-661hnu-f1>
 <5A99E897-60EC-486C-94D9-775B3C01FB16@holtmann.org>
 <20130915200021.GA8409@x220.p-661hnu-f1>
 <B44973E0-9AF5-4AE2-8C81-E49EE46C6E31@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <B44973E0-9AF5-4AE2-8C81-E49EE46C6E31@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Sep 15, 2013, Marcel Holtmann wrote:
> I have nothing against ENOENT. I however am a bit concerned about that
> we accidentally use ENOENT in some other case and end up overloading
> its meaning.
> 
> So just for the sake of making this unique, I would consider going
> with EBADSLT. I am not married to this at all. However I wanted to
> have this talked through so that we understand the whole picture. If I
> would know the perfect answer, I would have just forced you to use it
> ;)

I really don't have a strong opinion one way or another, both seem good
enough to me, but since ENOENT has you feeling a bit uneasy I'll change
this to EBADSLT for the next revision (which will hopefully be the last
one for this error code issue).

Johan
