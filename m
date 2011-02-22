Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110222191419.GA5469@jh-x301>
References: <1298367822-27766-1-git-send-email-luiz.dentz@gmail.com>
	<20110222191419.GA5469@jh-x301>
Date: Tue, 22 Feb 2011 22:23:54 +0200
Message-ID: <AANLkTinRmg+uuQcfUnK4pH34MHjSbq2hqcnvqtT25WFc@mail.gmail.com>
Subject: Re: [PATCH 1/5] Add support for pcsuite lock file
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Feb 22, 2011 at 9:14 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Luiz,
>
> On Tue, Feb 22, 2011, Luiz Augusto von Dentz wrote:
>> This should make others applications able to detect when pcsuite is
>> connected.
>> ---
>>  plugins/ftp.c |  160 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>>  1 files changed, 154 insertions(+), 6 deletions(-)
>
> Doesn't compile (ssize_t correct format string is %zd):
>
> plugins/ftp.c: In function 'ftp_put':
> plugins/ftp.c:288: error: format '%d' expects type 'int', but argument 6 has type 'ssize_t'

Will fix it and send a new version.

> Also, all the added debug prints don't seem to relate to the commit
> message in anyway. Probably better to split into a separate patch?

Yep, will do it too.

-- 
Luiz Augusto von Dentz
Computer Engineer
