Return-Path: <cyrus@holtmann.org>
Message-ID: <20110617122836.75292sf1oprtrhwk@mail.hendrik-sattler.de>
Date: Fri, 17 Jun 2011 12:28:36 +0200
From: Hendrik Sattler <post@hendrik-sattler.de>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 4/4] Add copy and move support for filesystem
 plugin
References: <1308292007-2111-1-git-send-email-luiz.dentz@gmail.com>
 <1308292007-2111-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1308292007-2111-4-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=ISO-8859-1;
 DelSp="Yes";
 format="flowed"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Zitat von Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Move is implemented using rename and copy uses sendfile, both part of
> posix.

Did you ever take a look at the "cp" implementation in coreutils? [1]
Additionally, the obex spec says that the copy/move actions also  
copies/moves directories recursively.

HS

[1]: http://git.savannah.gnu.org/cgit/coreutils.git/tree/src/copy.c

