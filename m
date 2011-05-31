Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110531075749.GA18878@dell.ger.corp.intel.com>
References: <1306828085-30834-1-git-send-email-iwamatsu@nigauri.org> <20110531075749.GA18878@dell.ger.corp.intel.com>
From: Nobuhiro Iwamatsu <iwamatsu@debian.org>
Date: Tue, 31 May 2011 17:04:26 +0900
Message-ID: <BANLkTi=AVP1E31fOftqAAb0rQfkqa7ge4A@mail.gmail.com>
Subject: Re: [PATCH] Fix install path for udevdir
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

2011/5/31 Johan Hedberg <johan.hedberg@gmail.com>:
> Hi,
>
> On Tue, May 31, 2011, Nobuhiro Iwamatsu wrote:
>> From: Nobuhiro Iwamatsu <iwamatsu@debian.org>
>>
>> If PCMCIA enabled, udevdir value override from /lib/udev to
>> $(libexecdir)/udev.
>>
>> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@debian.org>
>> ---
>>  Makefile.am |    2 --
>>  1 files changed, 0 insertions(+), 2 deletions(-)
>
> Thanks. The patch has been pushed upstream (with the signed-off-by line
> removed since we don't use that).

Thanks and sorry.
I am careful from next.

Best regards,
  Nobuhiro


-- 
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org}
   GPG ID: 40AD1FA6
