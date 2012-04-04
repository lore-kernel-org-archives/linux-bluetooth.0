Return-Path: <cyrus@holtmann.org>
Date: Wed, 4 Apr 2012 13:07:07 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Rafael Fonseca <fonsecasantos.rafael@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix spelling errors.
Message-ID: <20120404100707.GD11856@x220>
References: <1333458982-8661-1-git-send-email-fonsecasantos.rafael@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333458982-8661-1-git-send-email-fonsecasantos.rafael@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafael,

On Tue, Apr 03, 2012, Rafael Fonseca wrote:
> As my first attempt to send a patch to the project, I have used the
> codespell tool (https://github.com/lucasdemarchi/codespell) to search for
> spelling errors in the code.
> 
> If the patch is ok, could someone apply it, please?
> 
> Signed-off-by: Rafael F. Santos <fonsecasantos.rafael@gmail.com>
> ---
>  audio/telephony-maemo5.c |    2 +-
>  audio/telephony-maemo6.c |    2 +-
>  audio/unix.c             |    2 +-
>  mgmt/main.c              |    2 +-
>  sbc/sbc.h                |    2 +-
>  src/uinput.h             |    2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)

I had to fix up the commit message to remove stuff that shouldn't be
there (the story about this being your first patch and the signed-off-by
line). Anyway, the patch has now been pushed upstream. Thanks.

Johan
