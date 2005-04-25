Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <426D0162.4070500@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] A2DP sink code finally
References: <20050424150930.71134.qmail@web8308.mail.in.yahoo.com>	<426C62D4.80009@xmission.com> <20050425080812.41cf1fab.henryk@ploetzli.ch>
In-Reply-To: <20050425080812.41cf1fab.henryk@ploetzli.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Mon, 25 Apr 2005 08:40:34 -0600

Henryk,

I'm not sure anyone has used the dongle yet. (Mayank?)

I'll be trying it once I have another machine set up to run a2play.

Brad

Henryk Plötz wrote:
> Moin,
> 
> Am Sun, 24 Apr 2005 21:24:04 -0600 schrieb Brad Midgley:
> 
> 
>>Thanks for the submission. I corrected some warnings, disabled unused 
>>functions, and added it to Makefile.am.
> 
> 
> Ah, thanks.
> 
> 
>>We definitely need to do a lot of cleanup (eg now that a2play and
>>a2snk  have so much duplication), but first off we need to see why
>>audio is  being distorted...
> 
> 
> Hmm, how do I test that? I can't seem to get my audio dongle to connect.
> Is there anything else I've got to do apart from 
> | hciconfig hci0 class 0x200404
> | sdptool add A2SNK
> | ./a2snk
> ?
> 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
