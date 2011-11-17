Return-Path: <cyrus@holtmann.org>
Message-ID: <4EC5496F.2080509@xenotime.net>
Date: Thu, 17 Nov 2011 09:50:39 -0800
From: Randy Dunlap <rdunlap@xenotime.net>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 "Gustavo F. Padovan" <padovan@profusion.mobi>,
 linux-bluetooth@vger.kernel.org
Subject: Re: linux-next: Tree for Nov 17 (bluetooth)
References: <20111117150733.a70faf2c9030d511d5367e1e@canb.auug.org.au>
In-Reply-To: <20111117150733.a70faf2c9030d511d5367e1e@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On 11/16/2011 08:07 PM, Stephen Rothwell wrote:
> Hi all,


When CONFIG_BT_L2CAP is not enabled:

net/built-in.o: In function `hci_dev_open':
(.text+0xdce9a): undefined reference to `enable_hs'

-- 
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
