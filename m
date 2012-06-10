Return-Path: <cyrus@holtmann.org>
Message-ID: <4FD4D920.6060207@shapeseeker.com>
Date: Sun, 10 Jun 2012 18:28:00 +0100
From: Brian Smith <door@shapeseeker.com>
MIME-Version: 1.0
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Small Patch for scotest.c
References: <4FD111EB.8070307@shapeseeker.com> <20120610084658.GB28539@x220.P-661HNU-F1>
In-Reply-To: <20120610084658.GB28539@x220.P-661HNU-F1>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Johan Hedberg wrote:
> Hi Brian,
>
> On Thu, Jun 07, 2012, Brian Smith wrote:
>   
>> Hi there.
>> Here is a tiny 3-line patch to scotest.c to get it working. (I've
>> been trying to get bluez working on a Raspberry Pi, hitting USB
>> problems, having a workng scotest is helpful). The problem is that
>> bdaddr never gets initialized and tends to have random data in it,
>> preventing the client/server end from matching up.
>>
>> 344a345,346
>>     
>>>       hci_devba(0, &bdaddr);
>>>
>>>       
>
> Please only send patches in unified diff format. If you want them
> applied upstream they should be created using "git format-patch" and
> preferably sent with "git send-email".
>
> However, in this case I don't think your patch is quite right even if it
> was in the right format. Looking at bdaddr in scotest.c it's a static
> variable and to my understanding those should (according to the C
> standard) always get implicitly initialized to 0 if the code itself
> doesn't do so. At least gcc should follow this, so which compiler are
> you really using?
>
> Furthermore, assuming that this (zero-initialized bdaddr) is how scotest
> behaves for most people (as it's existed many years and you're the first
> one to face the issue), it's the same as using BDADDR_ANY. Therefore,
> I'd just go ahead and remove the bdaddr variable and replace the places
> where it was used with BDADDR_ANY (and please format the patch like I
> described above). Thanks.
>
> Johan
>
>   
Hi Johan.
Thanks for taking the time to look at my email and the feedback. Yes, 
you are right about the static variable initialization, bdaddr starts as 
0:0:0:0:0:0, but my understanding of what hci_devba() does was wrong.  
It changes baddrr from 0 to the MAC address of hci0, the local bluetooth 
adapter, which does actually seem to make scotest work properly (In 
practice it certainly does from the testing I've done. I can imagine 
that when both the server and client MAC address are 0/BDADDR_ANY it 
could cause problems). So I think the general idea of the patch is right 
at least. (It just came from comparing scotest.c with l2test.c really). 
Also I'm not the first person to see this, I found this unresolved issue 
when googling the problem initially:

http://comments.gmane.org/gmane.linux.bluez.kernel/3122

-- 
Brian Smith.
"The bells of clocktowers stitch the sleeper's dreams together." - Memory Palace

