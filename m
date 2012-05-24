Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 May 2012 03:12:21 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [RFC 0/8] Another step in l2cap_core/sock separation
Message-ID: <20120524061220.GD21117@joana>
References: <1337821964-4618-1-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337821964-4618-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Gustavo Padovan <gustavo@padovan.org> [2012-05-23 22:12:36 -0300]:

> From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> 
> Hi,
> 
> This patchset does a bit more of clean up in l2cap core, it was inially based
> on the two patches Andrei has sent to the list today.

For those interested in this work, a good measure of how good we are is:

$ egrep -rn "\<sk\>" net/bluetooth/l2cap_core.c | wc -l

Before this patchset of 11 patches we were counting 113 here, now we down to 77
occurrences of "sk" in the file with bt_sk(sk)->{src,dst} and socket locks
being the biggest users.

	Gustavo
