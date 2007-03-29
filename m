Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <460B708B.5060302@access-company.com>
Date: Thu, 29 Mar 2007 09:53:47 +0200
From: Frederic Dalleau <frederic.dalleau@access-company.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <45EF0B04.2080303@xmission.com>
	<200703101746.46586.bluez-devel@huitl.de>
In-Reply-To: <200703101746.46586.bluez-devel@huitl.de>
Subject: Re: [Bluez-devel] sbc encoder work
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


I agree, the sound has better gain and do not break at high volumes.
I have not noticed the clicks you talked about but I only have done a 
quick test.

Frederic


Robert Huitl wrote:
> Hi,
>
>   
>> I just committed some contributions to the sbc encoder to improve the
>> quality and volume of the audio. Please help us test this. We'll need
>> test files if you find something that doesn't work.
>>
>> Thanks to Walter Guerra and Alexsandro Santos for their work on this.
>>     
>
> Very nice work! I have the new code running for half an hour now with no 
> issues and greatly improved volume. There are some clicks occasionally, but 
> no more than I had with the old code (maybe even less). I have some sound 
> file that used to produce more clicks than any other, but cannot remember its 
> name at the moment. I will try it as soon as I remember... :)
>
> Robert
>
>
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>   


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
