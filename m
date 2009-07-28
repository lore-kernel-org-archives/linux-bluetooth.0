Return-Path: <cyrus@holtmann.org>
Message-ID: <30761901.1248770182239.JavaMail.root@safetgram>
Date: Tue, 28 Jul 2009 18:36:30 +1000
From: John Freeman <johnf@optimation.com.au>
MIME-Version: 1.0
To: Brad Midgley <bmidgley@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Intermittent "Address already in use" error
References: <1346165.1248430092866.JavaMail.root@safetgram> <5111969.1248454126654.JavaMail.root@safetgram>
In-Reply-To: <5111969.1248454126654.JavaMail.root@safetgram>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Brad Midgley wrote:
> John,
> 
>> From time to time, I encounter an "Address already in use" error when
>> attempting to bind a socket to a particular local adapter.  The python
>> code looks like:
>>
>>   Listener = BluetoothSocket(SCO)
>>   Listener.bind((addr1, ))
>>   Listener.listen(1)
> 
> Is the error appearing when you want to rebind a short time after it
> was used? Maybe you need to setsockopt SO_REUSEADDR just like you
> would if you wanted to quickly rebind a tcp serversocket.

Brad,

Thanks for the suggestion.  At first sight, that seemed like a possible cause. 
However, further testing shows that I can make another attempt a few seconds 
(limited by the speed of my fingers) after the socket has been closed, and that 
it is usually successful.

When it fails, /sys/class/bluetooth/sco contains:

    A2:C7:07:83:15:00 00:00:00:00:00:00 4

where "A2:C7:07:83:15:00" matches addr1 in the code above.  Normally, content 
appears in /sys/class/bluetooth/sco at the point of bind(), is modified slightly 
by listen(), then disappears on close of the Listener socket.

Once it gets into this state, all further attempts to bind fail with "Address 
already in use" ... until I reboot.

I haven't been able to pin down the exact circumstances that trigger the problem 
other than that it seems more likely to occur following a program run that fails 
with an unhandled exception.  That is, it seems like things aren't cleaned-up 
correctly sometimes. Unfortunately, I can't make it happen at will.

Any more ideas?

John.


