Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1374208312-18661-1-git-send-email-sathish.n@globaledgesoft.com>
References: <1374208312-18661-1-git-send-email-sathish.n@globaledgesoft.com>
Date: Fri, 19 Jul 2013 07:03:56 -0400
Message-ID: <CAJdJm_Ovac4BYhhRc-5H7t8wazeT28f0gvb5bOO8yzQ_rbuD-w@mail.gmail.com>
Subject: Re: [PATCH BlueZ] attrib: Fix interactive gatttool segfault
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Sathish Narasimman <sathish.n@globaledgesoft.com>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com,
	girish.br@globaledgesoft.com, ajay.kv@globaledgesoft.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sathish,

On Fri, Jul 19, 2013 at 12:31 AM, Sathish Narasimman
<sathish.n@globaledgesoft.com> wrote:
> passing the special character single quote
>
> $gatttool -I
> [   ][                 ][LE]> '
> Segmentation fault (core dumped)
>
> Checking g_shell_parse_argv fail status(return FALSE on failure), works fine.
>
> hope the fix to the previous "git am" error is solved

"git am" on this patch worked here. But one small note (for future
patches; I think there is no need to resend this one as it is easily
fixed locally): if you need to put a comment like the above that you
don't want to appear on the GIT commit message, you should put it
after "---" so it is ignored by "git am". They way I do this is use
"git format-patch" to generate a *.patch file, then I edit this file
to add the note after the "---" and send the patch using git send-mail
<file>.patch.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
