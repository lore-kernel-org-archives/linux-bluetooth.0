Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] monitor: Add support for limiting btsnoop files size
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1827472.lXlVGyKfTn@ix>
Date: Fri, 5 Jan 2018 16:23:45 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <200D19DD-9B57-41CC-BD8D-C42F83559AD1@holtmann.org>
References: <20180104140702.16321-1-szymon.janc@codecoup.pl>
 <872F3BD6-566A-423B-ADC2-48CACDED2DD5@holtmann.org> <1827472.lXlVGyKfTn@ix>
To: Szymon Janc <szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

>>> This adds new option -l (--limit) which allows to limit maximum
>>> size of writen btsnoop file. After limit is reached new btsnoop
>>> file will be created. To distinguish file postfix in for of
>>> _DATE_TIME is added to path provided with -w option. For convenience
>>> KkMm modifiers are also supported.
>>> 
>>> This is especially useful on unattended systems for tiding btmon
>>> with log rotation.
>>> 
>>> Example result of running btmon -w test.bin -l 10k
>>> test.log_2018-01-04_14:55:06_694638
>>> test.log_2018-01-04_14:56:15_933158
>>> test.log_2018-01-04_14:57:20_741201
>>> test.log_2018-01-04_14:58:13_280835
>>> test.log_2018-01-04_14:59:02_183569
>>> test.log_2018-01-04_15:00:05_352733
>>> test.log_2018-01-04_15:00:54_475147
>>> test.log_2018-01-04_15:01:57_183352
>> 
>> this is the quick and dirty approach. However a bit cleaner one would be
>> that we actually add information to each file where the next one can be
>> found. And preferably also which one was the previous one. I realize that
>> any kind of renaming kills this, so maybe this needs to be based on some
>> sort of hash that we include in each file as a identification header. And
>> then the reader needs to figure this out by itself and maybe try some
>> patterns to find the file or as proposed by Luiz, you give a glob matching
>> number of files and we ensure they are all sorted correctly.
>> 
>> In addition to this, maybe a round-robin schema is also useful, so that
>> earlier logs get overwritten. Something like "use max 10M and split over 10
>> files” is generally more useful then some uncontrolled rotation. So
>> suffixes of *.1, *.2 etc are normally easier to deal with.
>> 
>> Also in that context, introducing compressed log files would be interesting
>> feature as well. I would be curious if compressing these actually has a big
>> impact. I would assume with audio data it might actually safe a lot. If you
>> rotate and compress, then this becomes really useful.
> 
> I want to keep this as simple as possible since this is intended to work with 
> log rotation systems, not be used directly by human. The main goal was to 
> avoid need of restarting btmon when switching btsnoop file (to avoid loosing 
> traces). Compression, removing old etc is job of logrotate, not btmon. I 
> choose date-time for suffixes not only for human convenience but also for 
> (reasonable) level of uniqueness eg in case of btmon restart (I could shorten 
> it and skip usecs to keep it a bit simpler).

it is debatable that it is the job of log rotate. I think when you bring in external log rotating software, then you bring in a lot of overhead. I rather have this all in btmon and all self contained. Like for example the journal does it.

I think we should really think this through first. I prefer to have some hash entries in the file that points to n-1 and n+1 files of the set. That way later on they can also be combined or split up again if needed. So that part needs some solving. And as you noted before, we really want correct packet counting. So this is really useful for that as well.

Compressing can obviously done independent, but I think that once we are rotating that is something that is needed. Of course I fully realize that spawning a process or a thread then is needed here. And I dislike doing both of these. Then again, in theory with a POLLOUT and proper IO channel priority this can be done nicely as well. What I am saying is that once we extend btmon, lets think this all through to come up with something clean (which might means changes) since otherwise btmon is the next hcidump. Hacks stay hacks and make things unmaintainable.

I also want to some level that bt_shell can be used within btmon and making it scrollable and searchable. So that you have an input interface (as simple as vi for example) that allows you to enable/disable filters and options. But I also want to get away from readline or ncurses and drive the terminal by ourselves. Or even better if we get something along the lines of tig etc.

Just on that note, you also want a writer only btmon as it seems. Since the dual write to file and decode is pretty much useless. Also the overall decoding capability consume a lot of extra memory. A writer only btmon would be tiny. So we might actually consider doing just that first. I am struggling a bit with a good name for that, but maybe btmon-daemon, btmon-logger or something along these lines.

Regards

Marcel

