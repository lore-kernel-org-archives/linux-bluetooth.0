Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110617122836.75292sf1oprtrhwk@mail.hendrik-sattler.de>
References: <1308292007-2111-1-git-send-email-luiz.dentz@gmail.com>
	<1308292007-2111-4-git-send-email-luiz.dentz@gmail.com>
	<20110617122836.75292sf1oprtrhwk@mail.hendrik-sattler.de>
Date: Fri, 17 Jun 2011 13:56:52 +0300
Message-ID: <BANLkTi=Pfd=AZFknskQEqH1PUcvYercD8w@mail.gmail.com>
Subject: Re: [PATCH obexd 4/4] Add copy and move support for filesystem plugin
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Hendrik Sattler <post@hendrik-sattler.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hendric,

On Fri, Jun 17, 2011 at 1:28 PM, Hendrik Sattler
<post@hendrik-sattler.de> wrote:
> Zitat von Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
>>
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> Move is implemented using rename and copy uses sendfile, both part of
>> posix.
>
> Did you ever take a look at the "cp" implementation in coreutils? [1]
> Additionally, the obex spec says that the copy/move actions also
> copies/moves directories recursively.

Well need to check in the spec because for deleting recursively is not
mandatory so I supposed the copy/move wouldn't be either.  As for cp,
I did look, obviously I won't incorporate that much of code in obexd
and sendfile does actually do a lot of the checks there without
copying the data to the userspace. So what really is your point here,
that I should call system cp instead of sendfile?

-- 
Luiz Augusto von Dentz
