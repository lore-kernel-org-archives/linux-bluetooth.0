Return-Path: <cyrus@holtmann.org>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=Windows-1252;
 reply-type=original
Message-id: <ACE9435E5AA74C5E8865E6305BD25DFF@sisodomain.com>
From: Syam Sidhardhan <s.syam@samsung.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
References: <1361203483-32117-1-git-send-email-s.syam@samsung.com>
 <20130218161331.GA5539@x220.P-661HNU-F1>
 <CAMOw1v4sYhps4ABc5Z059j9hxPQjQHSAfb3PJfVr53q+OPQH=A@mail.gmail.com>
In-reply-to: <CAMOw1v4sYhps4ABc5Z059j9hxPQjQHSAfb3PJfVr53q+OPQH=A@mail.gmail.com>
Subject: Re: [PATCH 1/2] tools: Fix compilation error with GINT_TO_POINTER
Date: Tue, 19 Feb 2013 15:00:14 +0530
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

-----Original Message----- 
From: Lucas De Marchi
Sent: Monday, February 18, 2013 10:14 PM
To: Syam Sidhardhan ; linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] tools: Fix compilation error with GINT_TO_POINTER

On Mon, Feb 18, 2013 at 1:13 PM, Johan Hedberg <johan.hedberg@gmail.com> 
wrote:
> Hi Syam,
>
> On Mon, Feb 18, 2013, Syam Sidhardhan wrote:
>> Fixes the following error:
>> tools/btmgmt.c: In function ‘index_rsp’:
>> tools/btmgmt.c:756:10: error: cast to pointer from integer of different 
>> size [-Werror=int-to-pointer-cast]
>> tools/btmgmt.c: In function ‘cmd_info’:
>> tools/btmgmt.c:791:9: error: cast to pointer from integer of different 
>> size [-Werror=int-to-pointer-cast]
>> cc1: all warnings being treated as errors
>> make[1]: *** [tools/btmgmt.o] Error 1
>> make: *** [all] Error 2
>> ---
>>  tools/btmgmt.c |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> This patch has been applied. For whatever reason I did not get this
> warning/error in my environment. Which gcc version and architecture are
> you using?

The problem is more likely to be in the different glib versions and
running on 32 bits:
https://bugzilla.gnome.org/show_bug.cgi?id=661546

I found this in gcc version 4.6.3 for PC arch(i386 on ubuntu 12.04) with 
glib version 2.28.0.

Regards,
Syam 

