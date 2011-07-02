Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/3] build: Rename configfiles option to datafiles
From: Marcel Holtmann <marcel@holtmann.org>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 01 Jul 2011 20:50:17 -0700
In-Reply-To: <1309577712-3828-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1309577712-3828-1-git-send-email-lucas.demarchi@profusion.mobi>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1309578619.21109.0.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

> Instead of passing --[disable|enable]-configfiles, now we use
> --[disable|enable]-datafiles as not all of the files are installed for
> configuration but are rather data files.
> ---
>  Makefile.am    |    6 +++---
>  Makefile.tools |    2 +-
>  acinclude.m4   |    8 ++++----
>  3 files changed, 8 insertions(+), 8 deletions(-)

patch has been applied, but you forgot bootstrap-configure. I fixed that
one for you.

Regards

Marcel


