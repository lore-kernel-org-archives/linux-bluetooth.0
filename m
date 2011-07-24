Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: "Peter Hurley" <peter@hurleysoftware.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: A couple of questions related to a rfcomm server
Reply-To: santoscapela@gmail.com
References: <op.vyj0grkdv7v2p6@capela.tziranda.net>
 <1311524784.2657.21.camel@THOR>
Date: Sun, 24 Jul 2011 23:08:00 +0100
MIME-Version: 1.0
From: =?iso-8859-15?Q?S=E9rgio_Capela?= <santoscapela@gmail.com>
Message-ID: <op.vy483mhctnyi5l@mediacenter.lan>
In-Reply-To: <1311524784.2657.21.camel@THOR>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Sun, 24 Jul 2011 17:26:24 +0100, Peter Hurley  
<peter@hurleysoftware.com> wrote:

> Hi Sérgio,
>
> On Wed, 2011-07-13 at 06:51 -0400, Sérgio Capela wrote:
>> Hello,
>>
> ...
>> Is it possible to accept connections at the same time a inquiry is  
>> running
>> or is the inquiry a blocking operation at the stack level? With two
>> adapters my server accepts remote connections and receives and sends  
>> data
>> but when an inquiry is running it stops accepting connections. The  
>> inquiry
>> is done in a separate thread.
>
> That's handled in the controller at the baseband level. I don't know of
> any controllers that will accept connections while in the Inquiry
> substate - I'm not even sure if it's possible.
>
> Why are you initiating discovery from the server-side?
>

Well, this is a test where I'm trying to see if content delivery is viable  
through bluetooth and in this case the content depends on context. Imagine  
a number of rooms which should serve differentiated content accordingly.  
The server side discovery would try to automatically infer which content  
should be delivered to a given possible client. For this purpose I perform  
inquiries with rssi and thus the servers would act like tracking devices  
which would transmit inquiry data to a central database. These are only  
trials for now and I know that inquiries with rssi values are not that  
good for this type of decision so in the future this operation can be  
dropped in favor of other solution even if it end up as a choice at the  
user side.


> If you have to have server-side discovery, you could only perform
> inquiry with one controller at a time. That way, the other controller's
> available for new rfcomm connections (assuming your client load-balances
> like that...).
>

Yep, that is what I'm doing. I bind one adapter to the rfcomm server and  
use the other one for discovery and content delivery. The main process  
thread is the accept server and both the inquiry and the content delivery  
are done in threads launched for the purpose. I also made more tests  
recently and what is happening is that as soon as the inquiry starts the  
server stops accepting connections and starts processing inquiry result  
events, however, after a couple of minutes I can see the server both  
accepting and processing new connections and new inquiry result events.  
The end result is that launching an inquiry leads me to loose possible  
connections during a few minutes which is excessive for this case where  
inquiries would be launched regularly.

>> Another question is related to a rfcomm client getting into D state and
>> thus not killable. Due to my setup (two adapters in the same computer) I
>> can use the computer as both the server and the client. For test  
>> purposes
>> only I made a simple rfcomm client and I put it in a shell cycle thus
>> stressing the system regarding bluetooth connections. In this situation
>> the rfcomm client application becomes unresponsive after some time due  
>> to
>> a non exiting disk sleep. I then end up with multiple instances of the
>> same application and I can't kill them. By launching the application  
>> after
>> this I can see that the code blocks at a socket connection command
>> entering in a disk sleep state from which it doesn't exit. When this
>> happens I have to unplug the bluetooth adapter to get it working again
>> since it starts to give timeouts with hciconfig commands like "hciconfig
>> reset".
>>
>> Any ideas about this? The problem itself is not serious since it  
>> shouldn't
>> arise in normal conditions but it does require a reboot because of the
>> state D processes and makes the adapter unusable unless it is unplugged.
>
> Although I'm not certain that they would fix the problem you're having,
> I just posted a patch series that resolves some issues with lost wakeups
> in rfcomm and l2cap. They need testing. You'd need patches 1~4 of 7.
>
> Please feel free to reply direct regarding whether you can test these
> and what that outcome was.

I suppose those patches would be available in the git sources right? At  
the moment I can't test it but in a week or two I will try to compile the  
sources and unless I encounter some problem I will reply in this topic.


Regards,
Sérgio

>
> Regards,
> Peter


-- 
Sérgio Capela
