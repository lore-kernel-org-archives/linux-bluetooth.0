Return-Path: <cyrus@holtmann.org>
Message-Id: <1E808724-F721-415C-90F9-09C1B6E52C55@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1203988722.2754.220.camel@cookie.hadess.net>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Tue, 26 Feb 2008 02:21:37 +0100
References: <1200566602.26259.89.camel@cookie.hadess.net>
	<1200663790.2676.3.camel@cookie.hadess.net>
	<1201871693.2389.326.camel@cookie.hadess.net>
	<1201882130.2389.334.camel@cookie.hadess.net>
	<1201882826.2389.337.camel@cookie.hadess.net>
	<1202300325.3491.21.camel@cookie.hadess.net>
	<1202303303.3491.30.camel@cookie.hadess.net>
	<1202345972.3491.42.camel@cookie.hadess.net>
	<1203730228.2754.105.camel@cookie.hadess.net>
	<1203877746.2754.134.camel@cookie.hadess.net>
	<EB2E724A-6D73-4349-B937-7935A8C4BEFB@holtmann.org>
	<1203936997.2754.198.camel@cookie.hadess.net>
	<1203971803.28528.91.camel@californication>
	<1203988722.2754.220.camel@cookie.hadess.net>
Subject: Re: [Bluez-devel] [PATCH] Updated sendto
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

Hi Bastien,

>>>> So current patch is not acceptable. It is actually bad. So first
>>>> action must be to remove all these useless comments. An example  
>>>> is this:
>>>>
>>>> +       /* Go into main loop */
>>>>         gtk_main();
>>>>
>>>> Put comments where the code is unclear and not were everybody knows
>>>> what it is doing. This is a perfect example of wrongly commenting  
>>>> code.
>>>
>>> Done locally.
>>
>> do you have an updated patch or do I have to do it by myself.
>
> It was minimal changes, so I was waiting for response on the other
> issues.
>
>>>> Second of all, I am unhappy with all this usage of  
>>>> gtk_main_quit() in
>>>> various functions. Can we not just structure the code a lot more
>>>> cleaner to avoid multiple calls of it.
>>>
>>> I don't understand what you mean there.
>>
>> What I currently got from code review is that we simply call
>> gtk_main_quit() instead of having a little bit better structured  
>> code.
>> Just stopping the mainloop at more then 1 or 2 places doesn't seem  
>> right
>> to me. Feel free to convince me otherwise.
>
> All the uses of gtk_main_quit() could be "exit(0)" instead, but we  
> want
> to finish the mainloop and finish the cleaning up afterwards. It makes
> debugging memory leaks easier, as the program can exit cleanly after
> having mopped up after itself as hard as it could.
>
> There's one instance of gtk_main_quit() that we could move (the one in
> send_one shouldn't be needed, we should exit as soon as we know the
> filelist is empty).
>
>>>> Besides the signal handling, I
>>>> would expect one extra call in case we automatically wanna close  
>>>> the
>>>> progress dialog.
>>>
>>> Why? If there's no errors, why would you want to see it's  
>>> finished? What
>>> information would be in the dialogue that could be useful?
>>
>> That behavior is fine with me. However that was not what I said. So I
>> expect two gtk_main_quit() inside the code. One for SIGTERM and one  
>> when
>> we are actually done with the transfer.
>
> Do you just want us to exit() on error/user cancellation paths? It  
> makes
> no practical differences apart from the one mentioned above.

lets use gtk_main_quit() since the exit code doesn't really matter and  
show me an updated patch. I am still working through the whole thing.  
We need some simplifications here and there, because the code looks  
too complicated to me.

Regards

Marcel


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
