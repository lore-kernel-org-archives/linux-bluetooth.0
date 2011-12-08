Return-Path: <cyrus@holtmann.org>
Message-ID: <4EE0D0A0.2000401@linux.intel.com>
Date: Thu, 08 Dec 2011 15:58:40 +0100
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
CC: johan.hedberg@gmail.com
Subject: Re: [PATCH hciemu v2 1/2] Process Read Local AMP Info in hciemu
References: <1323334477-32179-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <20111208094032.GA28204@x220>
In-Reply-To: <20111208094032.GA28204@x220>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

Le 08/12/2011 10:40, Johan Hedberg a écrit :
> Hi Andrei,
>
> On Thu, Dec 08, 2011, Emeltchenko Andrei wrote:
>> Add processing of Read Local AMP Info in hciemu, the values returned are
>> used to emulate AMP HCI.
>> ---
>>   test/hciemu.c |   35 +++++++++++++++++++++++++++++++++++
>>   1 files changed, 35 insertions(+), 0 deletions(-)
>
> Both patches have been applied. Thanks.
>
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

This patch breaks the build on Ubuntu 10.10 32 bits with messages:

fdanis@fdanis-linux:bluez (master %)$ make
make --no-print-directory all-am
   CC     test/hciemu.o
cc1: warnings being treated as errors
test/hciemu.c: In function ‘hci_host_control’:
test/hciemu.c:431: error: dereferencing pointer ‘({anonymous})’ does 
break strict-aliasing rules
test/hciemu.c:431: note: initialized from here
make[1]: *** [test/hciemu.o] Error 1
make: *** [all] Error 2

Regards

Fred

-- 
Frederic Danis                            Open Source Technology Centre
frederic.danis@intel.com                              Intel Corporation

