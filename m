Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4D6D016B.8010308@nokia.com>
References: <1298749782-24129-1-git-send-email-luiz.dentz@gmail.com>
	<1298749782-24129-3-git-send-email-luiz.dentz@gmail.com>
	<4D6D016B.8010308@nokia.com>
Date: Tue, 1 Mar 2011 11:31:05 -0300
Message-ID: <AANLkTimu8tZT8BzycJ8ROFynrLgbHMfEK3JqU0PbkGuQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Move pcsuite drivers to its own plugin
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Tue, Mar 1, 2011 at 11:23 AM, Radoslaw Jablonski
<ext-jablonski.radoslaw@nokia.com> wrote:
>  Hi Luiz,
>
> On 02/26/2011 09:49 PM, ext luiz.dentz@gmail.com wrote:
>>
>> From: Luiz Augusto von Dentz<luiz.dentz-von@nokia.com>
>>
>> This make it easier to enable/disable this funcionality as a whole.
>> ---
>>  Makefile.am            |    6 +-
>>  configure.ac           |    9 +-
>>  plugins/ftp.c          |  165 +---------------
>>  plugins/ftp.h          |   30 +++
>>  plugins/nokia-backup.c |  309 -----------------------------
>>  plugins/pcsuite.c      |  515
>> ++++++++++++++++++++++++++++++++++++++++++++++++
>>  6 files changed, 561 insertions(+), 473 deletions(-)
>>  create mode 100644 plugins/ftp.h
>>  delete mode 100644 plugins/nokia-backup.c
>>  create mode 100644 plugins/pcsuite.c
>
> I've applied this patch and suddenly PC Suite stopped to discover if usb
> cable is connected (no possibility to take backup/restore via usb cable).
> In syslog there is no obexd logs in that scenario so hard to tell what
> went wrong:) After reverting to obexd release, based on upstream,
> everything started to work normally again.
>
> So, does other components (which are using this backup functionality)
> need to make some changes to their code or something is wrong
> with that patch?

Did you remember to add --enable-pcsuite to rules, otherwise pcsuite
plugin won't compile.


-- 
Luiz Augusto von Dentz
Computer Engineer
