Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <471B5E66.1030601@cilnu.com>
Date: Sun, 21 Oct 2007 15:12:54 +0100
From: Jon Maber <jon@cilnu.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <6656b6540710182155m29cd7441l6dcb9a7d722d5417@mail.gmail.com>	<47189691.2000504@cilnu.com>
	<6656b6540710210008v5cc459dv6692a5e8ff888187@mail.gmail.com>
In-Reply-To: <6656b6540710210008v5cc459dv6692a5e8ff888187@mail.gmail.com>
Subject: Re: [Bluez-devel] BlueZ integration to LINUX kernel (ARM)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Robin,

once again, the work has been done already.  You really need to study 
the documentation and configure properly.   If you have a bluetooth 
module connected to a UART and it understands one of the supported HCI 
protocols then you don't need to write any kind of driver you just need 
to tell the bluetooth subsystem which UART to talk to, what protocol to 
talk with and the baud rate etc.  Typing 'man hciattach' will explain 
this well enough.  You would also do well to buy a decent book on Bluetooth.

I would advise you to direct further questions to the manufacturer of 
your Bluetooth module.  You will need to know which HCI protocol it 
supports, the baud rate, handshaking etc.

Jon


Robin Gujjar wrote:
> hi jon
> thanks for the reply .Jon i saw the source code i got it . now i want to
> write a bluetooth UART device driver for my board
> can you just give me some basic step how to go ahead because i am new to
> linux device driver .please help any on
>
> thanks and regrds
> Robin Singh
>
> On 10/19/07, Jon Maber <jon@cilnu.com> wrote:
>   
>> Robin,
>> the job is already done for you.  Download kernel 2.6.22 and take a look
>> in net/bluetooth - you will see that the source code is there already.
>> Run menuconfig and you will see bluetooth configuration options under
>> the networking heading.  The fact that you are building for ARM
>> shouldn't present any additional problems.
>> Jon
>>
>> Robin Gujjar wrote:
>>     
>>> hi every body
>>>
>>> i am newbie to bluetooth .i want to integrate blueZ to my linux kernel
>>> 2.6.22 can any body plz give me some basic step to do that .
>>>
>>> thanks in advance
>>>
>>> Robin Singh
>>>
>>>
>>> ------------------------------------------------------------------------
>>>
>>>
>>>       
>> -------------------------------------------------------------------------
>>     
>>> This SF.net email is sponsored by: Splunk Inc.
>>> Still grepping through log files to find problems?  Stop.
>>> Now Search log events and configuration files using AJAX and a browser.
>>> Download your FREE copy of Splunk now >> http://get.splunk.com/
>>> ------------------------------------------------------------------------
>>>
>>> _______________________________________________
>>> Bluez-devel mailing list
>>> Bluez-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>>>
>>>       
>> -------------------------------------------------------------------------
>> This SF.net email is sponsored by: Splunk Inc.
>> Still grepping through log files to find problems?  Stop.
>> Now Search log events and configuration files using AJAX and a browser.
>> Download your FREE copy of Splunk now >> http://get.splunk.com/
>> _______________________________________________
>> Bluez-devel mailing list
>> Bluez-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>>
>>     
>
>   
> ------------------------------------------------------------------------
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >> http://get.splunk.com/
> ------------------------------------------------------------------------
>
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>   


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
