Return-Path: <cyrus@holtmann.org>
Message-ID: <27008598.1249002400393.JavaMail.root@safetgram>
Date: Fri, 31 Jul 2009 11:06:35 +1000
From: John Freeman <johnf@optimation.com.au>
MIME-Version: 1.0
To: Brad Midgley <bmidgley@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Intermittent "Address already in use" error
References: <1346165.1248430092866.JavaMail.root@safetgram>	 <5111969.1248454126654.JavaMail.root@safetgram>	 <30761901.1248770182239.JavaMail.root@safetgram>	 <27042187.1248802358830.JavaMail.root@safetgram>	 <19071709.1248945485270.JavaMail.root@safetgram> <2648525.1248996255356.JavaMail.root@safetgram>
In-Reply-To: <2648525.1248996255356.JavaMail.root@safetgram>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Brad Midgley wrote:
>> Can anyone suggest where I should start looking?
> 
> Are you using a recent kernel and bluez?

Very recent:
Kernel  2.6.29.5-84.fc10.i686
bluez-4.30-2.fc10.i386

 > Do you have example code that
 > will cause the problem? Even better if it is in script like python.

The code that causes the problem is 4000 lines of python, most of which I can't 
publish; you probably wouldn't want to look at it anyway.  I haven't been able 
to reduce it to a simple example because minor changes cause the problem to 
disappear.  Even running strace on the program makes the problem go away, so it 
looks like it's timing-related.

I was asking where in kernel/bluez code should I start looking.

