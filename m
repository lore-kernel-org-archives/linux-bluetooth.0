Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <428C8D03.5090409@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Creating more than one instance of BlueZ
References: <20050519120627.77301.qmail@web8303.mail.in.yahoo.com>
In-Reply-To: <20050519120627.77301.qmail@web8303.mail.in.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Thu, 19 May 2005 06:56:35 -0600

Mayank,

I think the best you can expect is for bluez to see hci0 and hci1. then 
you've got to make sure your apps choose the right adapter.

brad

Mayank Batra wrote:
> Guys,
> 
> I am still looking for a reply...
> 
> This is very necessary since this is the deterrent
> that I am facing during development process.
> 
> Cause I now do not have access to a test PC.
> 
> Mayank.
> 
> 
> 
> --- Mayank Batra <mayankbatra@yahoo.co.in> wrote:
> 
>>Guys,
>>
>>Is it possible to create more than one instance of
>>BlueZ on my linux machine.
>>
>>That is if I have 2 dongles, but do not have a test
>>PC
>>and I want to test my code, is it possible to do it
>>with one PC ?
>>
>>Mayank
>>
>>
> 
> ________________________________________________________________________
> 
>>Yahoo! India Matrimony: Find your life partner
>>online
>>Go to: http://yahoo.shaadi.com/india-matrimony
>>
>>
>>
> 
> -------------------------------------------------------
> 
>>This SF.Net email is sponsored by Oracle Space
>>Sweepstakes
>>Want to be the first software developer in space?
>>Enter now for the Oracle Space Sweepstakes!
>>
> 
> http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
> 
>>_______________________________________________
>>Bluez-devel mailing list
>>Bluez-devel@lists.sourceforge.net
>>
> 
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 
> 
> ________________________________________________________________________
> Yahoo! India Matrimony: Find your life partner online
> Go to: http://yahoo.shaadi.com/india-matrimony
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by Oracle Space Sweepstakes
> Want to be the first software developer in space?
> Enter now for the Oracle Space Sweepstakes!
> http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
