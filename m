Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1292356246-24012-2-git-send-email-bgix@codeaurora.org>
References: <1292356246-24012-1-git-send-email-bgix@codeaurora.org>
	<1292356246-24012-2-git-send-email-bgix@codeaurora.org>
Date: Tue, 14 Dec 2010 16:29:25 -0400
Message-ID: <AANLkTikB4K__a3aS1L19nz4USmtEcU+GEufcFkqZLrUb@mail.gmail.com>
Subject: Re: [PATCH] Added enc_read_blob_req() API to ATT transport, to enable
 the reading of attributes that exceed the length of the MTU.
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Brian Gix <bgix@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	rshaffer@codeaurora.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Dec 14, 2010 at 3:50 PM, Brian Gix <bgix@codeaurora.org> wrote:
> --
> Brian Gix
> bgix@codeaurora.org
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
>
> ---
>  attrib/att.c |   19 +++++++++++++++++++
>  attrib/att.h |    2 ++
>  2 files changed, 21 insertions(+), 0 deletions(-)

Usually, patches sent do Bluez, starte with short commit messages like:

Add ...
Fix ...
Implement ...

Note that we don't use "Added", "Fixed" etc. See the git log for
reference. In this case, you should consider at least adding a short
summary and your original summary as the "commit description", in the
form:

<short summary, e.g. "Implement Read Blob Request">
<empty line>
<long description>

Also as Vinicius mentioned, I think your e-mail signature will show up
on the commit description if someone applies it with "git am". I
suggest you send your patches with "git send-email".

Another issue: looks your e-mail client replaced tabs with spaces (but
it might just be Google messing up on my side).

Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
