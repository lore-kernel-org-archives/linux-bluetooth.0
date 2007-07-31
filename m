Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46AE8396.1030501@gmail.com>
Date: Mon, 30 Jul 2007 21:34:30 -0300
From: Manuel Naranjo <naranjo.manuel@gmail.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <46AE7340.4010603@gmail.com>
	<d89ddf300707301726s6e657773td9e83a9dfd6b271d@mail.gmail.com>
In-Reply-To: <d89ddf300707301726s6e657773td9e83a9dfd6b271d@mail.gmail.com>
Subject: Re: [Bluez-devel] a2dp, sco and kernel version
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Brad Midgley escribi=F3:
> Manuel
>
>   =

>> Finally I compiled snd-bt-sco in my original kernel (2.6.17-13mdv) and I
>> got sco working. But with a very low quality of audio. So my question
>> is... How should I update my kernel?
>>     =

>
> sco is fairly low quality in the best circumstances, but it shouldn't
> be choppy or unintelligible for voice.
>
> brad
>   =


Brad,
I can talk with it, it sounds good, but off course running at 8Khz will =

not get a good sound quality (I will not get sounds with a higher frec =

of 4Khz), but anyway it's not the recommended way to work if I'm not wrong.
btsco app requires to have the headset all the time connected, killing =

my batteries, while headsetd isn't so power consuming. That's why I =

wanna know what I'm missing in order to get it running.
Thanks,
Manuel

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
