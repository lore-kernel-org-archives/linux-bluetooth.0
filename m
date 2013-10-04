Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Oct 2013 11:16:14 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 5/7] android: Android version of log.c
Message-ID: <20131004081612.GE2804@aemeltch-MOBL1>
References: <1380632319-7701-1-git-send-email-frederic.danis@linux.intel.com>
 <1380632319-7701-5-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380632319-7701-5-git-send-email-frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Oct 01, 2013 at 02:58:37PM +0200, Frederic Danis wrote:
> ---
>  android/log.c  |  172 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  android/main.c |   34 +++++++++++
>  2 files changed, 206 insertions(+)
>  create mode 100644 android/log.c

What is the status with review. Do I understand correctly that it needs to
be changed something like:

 void info(const char *format, ...)
 {
        va_list ap;
 
        va_start(ap, format);
 
-       android_log(LOG_INFO, format, ap);
+       vfprintf(stderr, format, ap);
+       fprintf(stderr, "\n");
 
        va_end(ap);
 }

If so I can change this myself and resend patch series.

Best regards 
Andrei Emeltchenko 

