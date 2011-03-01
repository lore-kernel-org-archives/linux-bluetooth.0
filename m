Return-Path: <cyrus@holtmann.org>
Date: Tue, 1 Mar 2011 15:45:15 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
Subject: Re: [PATCH 1/2] Move pcsuite drivers to its own plugin
Message-ID: <20110301184515.GA32583@jh-x301>
References: <1298749782-24129-1-git-send-email-luiz.dentz@gmail.com>
 <1298749782-24129-3-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1298749782-24129-3-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Sat, Feb 26, 2011, luiz.dentz@gmail.com wrote:
> This make it easier to enable/disable this funcionality as a whole.
> ---
>  Makefile.am            |    6 +-
>  configure.ac           |    9 +-
>  plugins/ftp.c          |  165 +---------------
>  plugins/ftp.h          |   30 +++
>  plugins/nokia-backup.c |  309 -----------------------------
>  plugins/pcsuite.c      |  515 ++++++++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 561 insertions(+), 473 deletions(-)
>  create mode 100644 plugins/ftp.h
>  delete mode 100644 plugins/nokia-backup.c
>  create mode 100644 plugins/pcsuite.c

Thanks. Both patches have been pushed upstream (with a couple of fixes
to the commit messages).

Johan
