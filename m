Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46953A08.7090704@gmail.com>
Date: Thu, 12 Jul 2007 01:44:00 +0530
From: Rogue <roguexz@gmail.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <46896137.90202@gmail.com>	<d89ddf300707021858u2e5e8f80k35794595254736f6@mail.gmail.com>	<468A7156.1050708@gmail.com>	<468A7BFB.4080401@access-company.com>
	<468A7FD8.8050302@access-company.com>
In-Reply-To: <468A7FD8.8050302@access-company.com>
Subject: Re: [Bluez-devel] A few questions about bluetooth-alsa project
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

Hi Frederic,

Frederic Dalleau wrote:
> Just one line more,
>   
>> However, when the softvol plugin is declared in .asoundrc, it appears in 
>> the mixer.
>>   
>>     
> Wouldn't this explain the PCM-2device you saw in gnome-xxx?
>
>   
Sorry for the late response. Thunderbird had moved this message to the 
junk folder. Yes, the PCM-2 device in the applet was due to the 
.asoundrc file. Once I removed the file everything was back to normal. 
Ideally I would have expected the new devices mentioned in the file to 
get appended to the available set, but I guess I need to spend some more 
time understanding how the alsa-sound architecture works and how does it 
treat the asoundrc file.

later,
Rogue

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
