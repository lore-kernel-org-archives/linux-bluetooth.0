Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130520235142.GA14092@x220>
References: <1368721510-14339-1-git-send-email-anderson.lizardo@openbossa.org>
	<1368801089-30703-1-git-send-email-anderson.lizardo@openbossa.org>
	<20130520235142.GA14092@x220>
Date: Tue, 21 May 2013 07:02:42 -0400
Message-ID: <CAJdJm_O31R-mBjJQZZOquvKQektw+6_n_oaCgKRu8Z3ng-eyTQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 1/2] plugins: Use open()/read() instead of
 fopen()/fread() on autopair
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Mon, May 20, 2013 at 7:51 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Lizardo,
>
> On Fri, May 17, 2013, Anderson Lizardo wrote:
>> +     fd = open("/dev/urandom", O_RDONLY);
>> +     if (fd < 0) {
>> +             ssize_t n;
>> +
>> +             n = read(fd, &seed, sizeof(seed));
>> +             if (n < (ssize_t) sizeof(seed))
>> +                     seed = time(NULL);
>> +
>> +             close(fd);
>> +     } else
>> +             seed = time(NULL);
>
> So, it's not always wise to go blindly copying code examples/suggestions
> from Marcel without thinking a bit. You're checking for invalid fd when
> you should be checking for a valid one (>= 0).

Sorry about letting this pass. I actually reviewed the snippet, but
was induced to some "braino" which now seems obvious.

I'll try to be more careful, specially given I could not test this
change (as I mentioned on the original patch, but not on this one).

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
