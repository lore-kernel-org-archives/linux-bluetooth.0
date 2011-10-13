Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 Oct 2011 14:28:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: NeilBrown <neilb@suse.de>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: Help understanding Agent 'capabilities'.
Message-ID: <20111013112830.GA20868@fusion.localdomain>
References: <20111013165526.0dbbe0fc@notabene.brown>
 <CABBYNZJs4zXqhPkSV6HUbLzFk7_-cuf-+kVgmw+A0hcMRCXLxw@mail.gmail.com>
 <20111013221432.625e1bfd@notabene.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111013221432.625e1bfd@notabene.brown>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Neil,

On Thu, Oct 13, 2011, NeilBrown wrote:
> What is the easiest way to find out what bluetooth version the controller is
> using?  I tried looking around and didn't find anything obvious.

E.g. the output of "hciconfig hci0 version" should show you this.

Johan
