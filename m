Return-Path: <cyrus@holtmann.org>
Message-ID: <989104.70409.qm@web56503.mail.re3.yahoo.com>
Date: Mon, 7 Dec 2009 19:41:40 -0800 (PST)
From: Shreesh Holla <hshreesh@yahoo.com>
Subject: Re: Accept closing question
To: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>







Hi,

I am building an application using the Bluez stack and needed to do the following:

after running accept, a seperate thread would call close() on that socket(while it is still pending) so I can restart the listener on a different RFCOMM port. I have tried close, shutdown and even tried closing a corresponding hci socket - but the accept never returns. I have also tried to do a HCIDEVDOWN. And finally, I tried pulling the actual dongle out and it still did not return from the accept.

So is there some other way to notify accept to return apart from having to send a connection in? This appears to be a bug - the above behaviour? If this is the way it is to work - would killing the original thread running the accept call tear down the socket too? Or does one have to kill the whole process to end the accept call?

I am using the newest Ubuntu running a 2.6.31 kernel. Additionally I'm running Linux inside a VM - though I dont see that being an issue.

And finally when I run this code through a debugger, I do get the accept returning. So it is some timing issue? I have introduced a pthread_yield(), sleep(25) too after the close() call - but accept never returns when run out of the debugger.

Thanks for any pointers on this.

Shreesh

