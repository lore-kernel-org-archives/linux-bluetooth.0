Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110223144413.GA26355@jh-x301>
References: <1298454881-7941-1-git-send-email-luiz.dentz@gmail.com>
	<1298454881-7941-5-git-send-email-luiz.dentz@gmail.com>
	<20110223144413.GA26355@jh-x301>
Date: Sat, 26 Feb 2011 15:52:28 -0300
Message-ID: <AANLkTikjXN=Kh7aVai4_Fycf0JhTANdebhBoCxpPMBGH@mail.gmail.com>
Subject: Re: [PATCH 5/6] Move pcsuite drivers to its own plugin
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Feb 23, 2011 at 11:44 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Luiz,
>
> On Wed, Feb 23, 2011, Luiz Augusto von Dentz wrote:
>> This make it easier to enable/disable this funcionality as a whole.
>> ---
>>  Makefile.am            |    6 +-
>>  configure.ac           |    9 +-
>>  plugins/ftp.c          |  165 ++------------------------
>>  plugins/nokia-backup.c |  309 ------------------------------------------------
>>  4 files changed, 16 insertions(+), 473 deletions(-)
>>  delete mode 100644 plugins/nokia-backup.c
>
> It seems like you've forgotten to do git add plugins/pcsuite.c?

Apparently I did, I will resend it once a figure out where this file
is or just redo it.

> Anyway, I went ahead and applied patches 1-4.
>
> Johan
>



-- 
Luiz Augusto von Dentz
Computer Engineer
