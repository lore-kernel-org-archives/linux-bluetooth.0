Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <47189691.2000504@cilnu.com>
Date: Fri, 19 Oct 2007 12:35:45 +0100
From: Jon Maber <jon@cilnu.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <6656b6540710182155m29cd7441l6dcb9a7d722d5417@mail.gmail.com>
In-Reply-To: <6656b6540710182155m29cd7441l6dcb9a7d722d5417@mail.gmail.com>
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
the job is already done for you.  Download kernel 2.6.22 and take a look 
in net/bluetooth - you will see that the source code is there already.  
Run menuconfig and you will see bluetooth configuration options under 
the networking heading.  The fact that you are building for ARM 
shouldn't present any additional problems.
Jon

Robin Gujjar wrote:
> hi every body
>
> i am newbie to bluetooth .i want to integrate blueZ to my linux kernel
> 2.6.22 can any body plz give me some basic step to do that .
>
> thanks in advance
>
> Robin Singh
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
