Return-Path: <cyrus@holtmann.org>
Message-ID: <4D6D016B.8010308@nokia.com>
Date: Tue, 01 Mar 2011 16:23:39 +0200
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
To: "ext luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
CC: linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
Subject: Re: [PATCH 1/2] Move pcsuite drivers to its own plugin
References: <1298749782-24129-1-git-send-email-luiz.dentz@gmail.com> <1298749782-24129-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1298749782-24129-3-git-send-email-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

  Hi Luiz,

On 02/26/2011 09:49 PM, ext luiz.dentz@gmail.com wrote:
> From: Luiz Augusto von Dentz<luiz.dentz-von@nokia.com>
>
> This make it easier to enable/disable this funcionality as a whole.
> ---
>   Makefile.am            |    6 +-
>   configure.ac           |    9 +-
>   plugins/ftp.c          |  165 +---------------
>   plugins/ftp.h          |   30 +++
>   plugins/nokia-backup.c |  309 -----------------------------
>   plugins/pcsuite.c      |  515 ++++++++++++++++++++++++++++++++++++++++++++++++
>   6 files changed, 561 insertions(+), 473 deletions(-)
>   create mode 100644 plugins/ftp.h
>   delete mode 100644 plugins/nokia-backup.c
>   create mode 100644 plugins/pcsuite.c

I've applied this patch and suddenly PC Suite stopped to discover if usb
cable is connected (no possibility to take backup/restore via usb cable).
In syslog there is no obexd logs in that scenario so hard to tell what
went wrong:) After reverting to obexd release, based on upstream,
everything started to work normally again.

So, does other components (which are using this backup functionality)
need to make some changes to their code or something is wrong
with that patch?

BR,
Radek

