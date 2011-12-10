Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20111209084828.GA24969@x220>
References: <1323334477-32179-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<20111208094032.GA28204@x220>
	<4EE0D0A0.2000401@linux.intel.com>
	<20111209081637.GB7256@aemeltch-MOBL1>
	<4EE1CA0F.2040402@linux.intel.com>
	<20111209084828.GA24969@x220>
Date: Sat, 10 Dec 2011 21:07:48 +0530
Message-ID: <CAFBvHieV1yujP7y8SEJw+DG59x-CP7rb_ZC0k2F9rWNUwi0TsQ@mail.gmail.com>
Subject: Re: [PATCH hciemu v2 1/2] Process Read Local AMP Info in hciemu
From: Syam Sidhardhan <syamsidhardh@gmail.com>
To: Frederic Danis <frederic.danis@linux.intel.com>,
	Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frederic,

On Fri, Dec 9, 2011 at 2:18 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Frederic,
>
> On Fri, Dec 09, 2011, Frederic Danis wrote:
>> >>fdanis@fdanis-linux:bluez (master %)$ make
>> >>make --no-print-directory all-am
>> >>   CC     test/hciemu.o
>> >>cc1: warnings being treated as errors
>> >>test/hciemu.c: In function ‘hci_host_control’:
>> >>test/hciemu.c:431: error: dereferencing pointer ‘({anonymous})’ does
>> >>break strict-aliasing rules
>> >>test/hciemu.c:431: note: initialized from here
>> >>make[1]: *** [test/hciemu.o] Error 1
>> >>make: *** [all] Error 2
>> >
>> >Cannot reproduce this problem on my Ubuntu 11.04. Are you sure the error is
>> >attributed to my patch?
>>
>> Yes, I replaced line 431 by:
>>       sa.sin_port = ba.b[4];
>> and there is no more build error.
>
> Ok, so the line *is* correct but the function reported by gcc isn't.
> This particular line was last changed way back in 2005 (check with git
> blame) by a commit from Marcel so I don't see how your issue could have
> been caused by recent changes. As I mentioned in the other email I'd
> expect you to provide a proper patch for this with a good commit message
> that explains why it is needed.
>
> Johan

I'm also getting the same error in my ubuntu 11.04 with a gcc version
(Ubuntu/Linaro 4.4.4-14ubuntu5) 4.4.5.
This can be reproduce with a fresh git clone and build in the above
mentioned ubuntu linux environment.
More logs can be found here: http://pastie.org/2995677.

Syam
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
