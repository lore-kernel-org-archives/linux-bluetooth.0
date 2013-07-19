Return-Path: <cyrus@holtmann.org>
Date: Fri, 19 Jul 2013 14:26:29 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Sathish Narasimman <sathish.n@globaledgesoft.com>
Cc: linux-bluetooth@vger.kernel.org, girish.br@globaledgesoft.com,
	anderson.lizardo@openbossa.org, ajay.kv@globaledgesoft.com
Subject: Re: [PATCH BlueZ] attrib: Fix interactive gatttool segfault
Message-ID: <20130719112629.GA741@x220.p-661hnu-f1>
References: <1374208312-18661-1-git-send-email-sathish.n@globaledgesoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1374208312-18661-1-git-send-email-sathish.n@globaledgesoft.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Satish,

On Fri, Jul 19, 2013, Sathish Narasimman wrote:
> passing the special character single quote
> 
> $gatttool -I
> [   ][                 ][LE]> '
> Segmentation fault (core dumped)
> 
> Checking g_shell_parse_argv fail status(return FALSE on failure), works fine.
> 
> hope the fix to the previous "git am" error is solved
> 
> ---
>  attrib/interactive.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

The patch has now been applied (after manually removing the last comment
that doesn't belong in the commit message). Thanks.

Johan
