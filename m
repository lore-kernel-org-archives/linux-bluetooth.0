Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
In-Reply-To: <1187969565.15402.188.camel@violet>
References: <9FADD91B-899B-45A5-A018-CAA3F97C976D@cadvium.net>
	<1187969565.15402.188.camel@violet>
Message-Id: <5639D66F-91F0-4954-9BD2-3C5A5D9D47CC@cadvium.net>
From: robert <rbscott@cadvium.net>
Date: Fri, 24 Aug 2007 08:51:08 -0700
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] handsfree profile
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

Hello Marcel,

Yeah, I agree this approach is kind of a mess, but it is in line with  
all of the goals of my project(portability, consistency, ease of use  
and development).  I would like to have as much done in java as  
possible.  If I write a lot of the code in C, then someone will have  
to port it when they move to another OS, or pray that the headset  
profile is as far along as the one in BlueZ, or worse pray that it  
exists at all.  I love C, but java is simply a more accessible  
language, making it easier for other developers to embellish the  
profile.

agree to disagree.  :)

cheers,
robert

On Aug 24, 2007, at 8:32 AM, Marcel Holtmann wrote:

> Hi Robert,
>
>> So I was planning to implement the profile inside of java, which is
>> why I am working on the Avetana BT stack, but I don't beleive that I
>> can handle any of the SCO communication from java.  Essentially I am
>> planning write the command processor for handling the AT commands in
>> Java (easier to maintain and debug), and then just create a small
>> daemon that handles routing traffic between the SCO channel and the
>> Alsa devices.  Perhaps communicate between the two using D-Bus?
>
> that makes my stomach turn around. You you are of course free to do  
> so,
> but doing everything in plain C is much easier.
>
> And I would advise to try an integration with our audio daemon.
> Otherwise it would become one of these external things that is hard to
> install and maintain.
>
> Regards
>
> Marcel
>
>
>
> ---------------------------------------------------------------------- 
> ---
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a  
> browser.
> Download your FREE copy of Splunk now >>  http://get.splunk.com/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
