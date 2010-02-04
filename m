Return-Path: <cyrus@holtmann.org>
Date: Thu, 4 Feb 2010 23:05:16 +0100
From: Frank Maas <frank.maas@cheiron-it.nl>
To: linux-bluetooth@vger.kernel.org
Subject: Problem with 'inquiry_cache' in sysfs
Message-ID: <20100204220516.GC8556@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear developers!

I have just connected to your mailing list as this is your prefered way 
of contact. So excuse me for barging in a bit... And excuse me if the 
following is too much text...

I am currently developing a system that relies heavily on the Linux 
bluetooth stack. That system uses the sysfs interface to the kernel 
module and more specifically the entry 'inquiry_cache' of the device 
"directory".

While using this approach I experienced strange errors, varying from a 
dead system, a system that went crazy, a system that spewed kernel 
errors and the worse effect was a straight kernel panic. After blaming 
everyone else (including myself) I found that I could reproduce the 
error quite simple by just 'cat'-ing the above named inquiry_cache.

[If you like to try yourself, then go to an area where you have a lot of ]
[of BT devices, wait for a while and do 'cat /sys/.../inquiry_cache'.    ]
[Or, to make it more certain that your system will crash: create a       ]
[script that continuously does that command.                             ]

So I took a dive in the code and I think I found the problem. The sysfs 
"documentation" says

	'Attributes should be ASCII text files, preferably with only 
	one value per file. It is noted that it may not be efficient to 
	contain only one value per file, so it is socially acceptable 
	to express an array of values of the same type. 
	... expressing multiple lines of data ... is heavily frowned 
	upon.'

a little bit further it states

	'To read [...] attributes, [a] show() [...] method must be
	specified [...] sysfs allocates a buffer of size (PAGE_SIZE) and 
	passes it to the method. '

The Bluetooth stack defines function show_inquiry_cache() to serve the 
above named file. For every entry in the cache a line is sprint'ed to 
the buffer. While doing so there is no check if it still fits the 
buffer. With a common value of 4096 for PAGE_SIZE it takes a bit more 
than 50 entries to create a bufferoverflow. Since this is in kernelspace 
bad things can and will happen...

I purposely quoted the documentation above since I have no simple 
solution. I fear that one can argue if 'inquiry_cache' should be 
available. It does not show a simple attribute(-list) but the contents 
of a cache that can be rather large. However I do see a benefit for 
having this cache available (I *am* using it, now am I).
Simply stop when the buffer is full is not an option since then one will 
not see the complete cache (and so one can miss newly detected devices). 
Showing only the most recent is a bit better, but one is still not 
seeing everything.


So there you have it. I had a quick scan through your mail archive and 
did not find this issue. I might have missearched or perhaps this topic 
has already been tackled elsewhere. If so then please redirect me and 
accept my appologies. 

Happy to hear from you,

Frank



