Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <470B51B6.7080306@access-company.com>
Date: Tue, 09 Oct 2007 12:02:30 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?= <frederic.dalleau@access-company.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <470A50E5.2090800@free.fr>	<1191862220.12212.3.camel@aeonflux.holtmann.net>	<470B3979.4080301@free.fr>
	<1191919524.31341.11.camel@aeonflux.holtmann.net>
	<470B4D3D.4080507@free.fr>
In-Reply-To: <470B4D3D.4080507@free.fr>
Subject: Re: [Bluez-devel] HFP design question : polls opened !
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

HFP syntax is quite basic
most comand provide few parameter so sscanf+strcmp is enough...

I feel  regexp power is not needed for these syntaxes.

Fred


Fabien Chevalier wrote:
> Hi Marcel, Frederic x2 & all
>
>>> Marcel, there is no portability issue with GRegex : it is completely 
>>> self contained (no external deps added). ;-)
>>
>> as I said, for BlueZ 4.x, no problem. Before that we have to see. Show
>> me example code for an AT parser. I purely will judge based on its
>> complexity.
>>
>
> That's a good way to judge indeed, however no way i spend 2 days 
> writing  an AT parser by hand just for you to have a 2 minutes looks 
> at it ;-)
>
> However Access guys have already written a parser,
> maybe either of our Frederic's can share with us their HFP parsing code,
> to see how it looks like ?
>
> FD and FD, what do you think ?
>
> Cheers,
>
> Fabien


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
