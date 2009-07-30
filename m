Return-Path: <cyrus@holtmann.org>
Message-ID: <19071709.1248945485270.JavaMail.root@safetgram>
Date: Thu, 30 Jul 2009 19:17:59 +1000
From: John Freeman <johnf@optimation.com.au>
MIME-Version: 1.0
To: Brad Midgley <bmidgley@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Intermittent "Address already in use" error
References: <1346165.1248430092866.JavaMail.root@safetgram>	 <5111969.1248454126654.JavaMail.root@safetgram>	 <30761901.1248770182239.JavaMail.root@safetgram> <27042187.1248802358830.JavaMail.root@safetgram>
In-Reply-To: <27042187.1248802358830.JavaMail.root@safetgram>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Brad Midgley wrote:
>> Once it gets into this state, all further attempts to bind fail with
>> "Address already in use" ... until I reboot.
> 
> if you're using kernel modules, you might be able to unload/reload a
> bluetooth related kernel module to restore it. This would also help
> narrowing down the cause.

The bad news is that I can't unload the sco or bluetooth modules when the 
problem occurs because they are allegedly "in use".

The good news is that I have found a combination of circumstances that makes the 
problem hard-on rather than intermittent.  As a result, I have discovered some 
additional symptoms.  In addition to the /sys/class/bluetooth/sco file that is 
not cleaned-up, there is also a /sys/class/bluetooth/rfcomm file with contents 
that correspond to a listen() on a RFCOMM socket.  There is also a leftover SDP 
entry arising from advertise_service() even after stop_advertising() has been 
called.

 From what I know of sysfs (learned during the past 24 hours), these entries are 
controlled by reference counts, so it looks like the counts are getting screwed 
somewhere.

Can anyone suggest where I should start looking?

John.


