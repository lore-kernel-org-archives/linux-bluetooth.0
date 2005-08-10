Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v733)
In-Reply-To: <AF23A417-8600-4F53-87AC-359586BD2AB1@pepper.com>
References: <AF23A417-8600-4F53-87AC-359586BD2AB1@pepper.com>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8B0AF3C0-969B-4843-94E8-92E7ECA4BD20@pepper.com>
From: Michael Frey <mfrey@pepper.com>
Subject: Re: [Bluez-devel] btsco with 2.6.12
To: bluez-devel@lists.sourceforge.net
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
Date: Wed, 10 Aug 2005 10:51:24 -0400

ok --

I got further -- I needed the HW_DEP built for my kernel.  I can now  
connect to my headset using btsco.

However when I play a wav file using aplay I just get static on the  
headset.

Any clues.

Michael

On Aug 9, 2005, at 4:09 PM, Michael Frey wrote:

> All,
>
> I am using a stock 2.6.12.3 kernel and just built btsco.  I am  
> getting an error when trying to run it and do not know what it means.
>
> root@(none):~# ./btsco
> Error: hwdep next device (hw:0): Operation not permitted
> Error: control open (hw:1): No such device
> Error: Can't find device. Bail
>
> I do have alsa set up and can play audio.  Am I just missing  
> something in my /etc/asound.conf?
>
>
> Michael
>
>
>
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle  
> Practices
> Agile & Plan-Driven Development * Managing Projects & Teams *  
> Testing & QA
> Security * Process Improvement & Measurement * http://www.sqe.com/ 
> bsce5sf
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
