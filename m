Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Oct 2013 14:20:00 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC 7/9] android: Fix building with local cutils/log.h
Message-ID: <20131017111958.GT2861@aemeltch-MOBL1>
References: <1382000128-23762-1-git-send-email-luiz.dentz@gmail.com>
 <1382000128-23762-8-git-send-email-luiz.dentz@gmail.com>
 <CAJdJm_MNvbK7XaLaapeE_rR4fTxsENjoNouBqx2eLXBOkaTfsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJdJm_MNvbK7XaLaapeE_rR4fTxsENjoNouBqx2eLXBOkaTfsQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

On Thu, Oct 17, 2013 at 06:57:29AM -0400, Anderson Lizardo wrote:
> Hi Luiz,
> 
> On Thu, Oct 17, 2013 at 4:55 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > android/hal_bt_sock.c: In function 'btsock_listen_rfcomm':
> > android/hal_bt_sock.c:30:47: error: expected ')' before '__func__'
> >   ALOGD(__func__);
> 
> You can implement ALOGD() using vfprintf() (just like DBG(), but which
> uses vsyslog() instead) and avoid this commit.

I agree here, we are anyway implementing ALOGD, let's implement it
correctly.

Best regards 
Andrei Emeltchenko 

