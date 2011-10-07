Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMOw1v5_EJNp3cS8u9QvKA87yELF7FE-nFAm_jSNWbtm_i4g_Q@mail.gmail.com>
References: <1317905191-30118-1-git-send-email-luiz.dentz@gmail.com>
	<CAMOw1v5_EJNp3cS8u9QvKA87yELF7FE-nFAm_jSNWbtm_i4g_Q@mail.gmail.com>
Date: Fri, 7 Oct 2011 12:58:04 +0300
Message-ID: <CABBYNZ+Dfe4uSJNG398DmmZC0Y3ooouj-Kdi5dcnAhbHiQHOrQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] Add mpris-player to test
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Fri, Oct 7, 2011 at 12:33 AM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> Hi Luiz
>
> On Thu, Oct 6, 2011 at 9:46 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>>
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> It gather information from players implementing mpris spec and convert
>> to org.bluez.MediaPlayer spec.
>> ---
>>  Makefile.tools      |    4 +-
>>  test/mpris-player.c |  959 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 962 insertions(+), 1 deletions(-)
>>  create mode 100644 test/mpris-player.c
>>
>
> What Media Player do you have? I've tried VLC and exaile here and both
> support only version 1.0. I didn't find one to support version 2.0

Fedora's rhythmbox, but I suppose there should be other player
implementing, or planning to implement, it too.

-- 
Luiz Augusto von Dentz
