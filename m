Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1341403768-16709-1-git-send-email-luiz.dentz@gmail.com>
References: <1341403768-16709-1-git-send-email-luiz.dentz@gmail.com>
Date: Wed, 4 Jul 2012 10:30:48 -0300
Message-ID: <CAJdJm_MDfnOOdjqk-AOJnRoRu37VO_JrzKFUGzyBXveaMi8sdw@mail.gmail.com>
Subject: Re: [RFC BlueZ] core: Fix not waiting for discovery to stop before
 attempting to pair
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Jul 4, 2012 at 9:09 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> In some cases, LE controllers, this can cause errors due to scan/inquiry
> being active.

Can you provide more background on which controllers did you see this issue?

Also, would it be appropriate to use the "LE Read Supported States"
HCI command to check the supported controller states on kernel and
make this check on kernel instead?

I suppose this will cause pairing delays even for controllers which do
not have this issue.

>
> To fix this instead of immediately attempting to pair wait until
> discovery is properly stopped and only then proceed with bonding.
> ---
> Still RFC because I could only test against controllers that used to
> work without this patch.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
