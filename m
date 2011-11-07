Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20111107193648.GA2597@fusion.localdomain>
References: <1320685115-20542-1-git-send-email-claudio.takahasi@openbossa.org>
	<20111107193648.GA2597@fusion.localdomain>
Date: Mon, 7 Nov 2011 16:08:45 -0400
Message-ID: <CAJdJm_OgkKPLnM_5e7w+iLMHW-pvx2MVeagot5mkdp4erKFH9Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ] btmgmt: fix used without initialization
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Mon, Nov 7, 2011 at 3:36 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Claudio,
>
> On Mon, Nov 07, 2011, Claudio Takahasi wrote:
>> This patch fixes the following warning being treated as error:
>> mgmt/main.c: In function 'mgmt_process_data':
>> mgmt/main.c:508:3: error: 'len' may be used uninitialized in this
>> function [-Werror=uninitialized]
>> ---
>>  mgmt/main.c |    6 ++++--
>>  1 files changed, 4 insertions(+), 2 deletions(-)
>
> Thanks for the heads-up. Seems like my gcc is buggy since it doesn't
> catch this even when I use bootstrap-configure. The original intent of
> the code was to have return ret which is what I pushed as a fix (-errno
> would be more sophisticated but then it'd make sense to fix several
> other places in the code too). Btw, please keep "int err" variables
> negative so that we have consistency in the code-base and avoid stupid
> bugs.

Actually we are not consistent yet:

$ grep -r 'int err.*errno;' *
audio/avdtp.c:		int err = -errno;
audio/avdtp.c:		int err = -errno;
btio/btio.c:		int error = -errno;
btio/btio.c:		int error = -errno;
btio/btio.c:		int error = -errno;
network/common.c:		int err = errno;
network/common.c:		int err = errno;
network/common.c:		int err = errno;
serial/port.c:		int err = -errno;
serial/port.c:		int err = -errno;
time/server.c:		int err = errno;   (*)
tools/hcitool.c:		int err = errno;

This one is from a patch I sent (not yet applied), will fix.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
