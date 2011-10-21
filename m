Return-Path: <cyrus@holtmann.org>
Date: Fri, 21 Oct 2011 11:14:06 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 bluez 0/2] Definitions needed for hcidump
Message-ID: <20111021081406.GA30417@fusion.localdomain>
References: <1318926191-17361-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318926191-17361-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Oct 18, 2011, Emeltchenko Andrei wrote:
> Those definitions are used in decoding L2CAP fixed channels
> 
> Andrei Emeltchenko (2):
>   add definitions for L2CAP fixed channels
>   add btohll / htobll macros
> 
>  lib/bluetooth.h |    4 ++++
>  lib/l2cap.h     |    5 +++++
>  2 files changed, 9 insertions(+), 0 deletions(-)

Both patches have been applied. Thanks

In the future, please start your commit messages with capital letters so
we maintain a consistent commit history.

Johan
