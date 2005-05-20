Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <428E1096.6040802@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Broadcast A2DP
References: <20050520151724.74783.qmail@web8306.mail.in.yahoo.com> <1116603730.8819.13.camel@pegasus>
In-Reply-To: <1116603730.8819.13.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 20 May 2005 10:30:14 -0600

Mayank,

>>What I want to know is that whether sufficient
>>bandwidth will be there or not?
> 
> I think it is not and besides this you might get into problems if you
> create a scatternet.

I suspect my itech clip is only insisting on being master if you 
"connect" (just rfcomm, not sco) it first to the phone. Maybe Marcel 
could clear it up if I'm wrong. Here's what I observe:

If the headset is connected (again, just rfcomm) and I start an a2dp 
stream to it from the computer, it works fine until I move my bluetooth 
mouse. The audio breaks up when the mouse is moving. What I suspect 
happens is the computer is master to the mouse and slave to the headset. 
I think the computer gives priority to its own piconet.

If the headset is not "connected" to the phone and I send music to it, I 
can move the mouse and there is no loss of audio. Trying to initiate the 
connection from phone to headset briefly causes the music to stop but 
the phone connection fails and the music starts again. It seems to me 
that the headset is just a slave device and won't be able to accept the 
incoming connection.

Brad


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
