Return-Path: <cyrus@holtmann.org>
Message-ID: <8006552.1249022191976.JavaMail.root@safetgram>
Date: Fri, 31 Jul 2009 16:36:27 +1000
From: John Freeman <johnf@optimation.com.au>
MIME-Version: 1.0
To: Brad Midgley <bmidgley@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Intermittent "Address already in use" error
References: <1346165.1248430092866.JavaMail.root@safetgram>	 <5111969.1248454126654.JavaMail.root@safetgram>	 <30761901.1248770182239.JavaMail.root@safetgram>	 <27042187.1248802358830.JavaMail.root@safetgram>	 <19071709.1248945485270.JavaMail.root@safetgram> <2648525.1248996255356.JavaMail.root@safetgram> <33459247.1249002454978.JavaMail.root@safetgram>
In-Reply-To: <33459247.1249002454978.JavaMail.root@safetgram>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

John Freeman wrote:
> Brad Midgley wrote:
>>> Can anyone suggest where I should start looking?
>> Are you using a recent kernel and bluez?
> 
> Very recent:
> Kernel  2.6.29.5-84.fc10.i686
> bluez-4.30-2.fc10.i386
> 
>  > Do you have example code that
>  > will cause the problem? Even better if it is in script like python.

[Red face mode]
Now I know the superficial cause of the problem.  The program ran hcidump:
subprocess.Popen(['hcidump', '-i', adapterId, '-w', fname])
in order to gather info on some other problems.  Under some circumstances it 
didn't clean up the process before terminating.

Killing the hcidump cleaned up the files in /sys/class/bluetooth and I no longer 
get the error.

If anyone can explain why, I'd be very interested.

