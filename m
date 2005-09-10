Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Samsung Z500 + bluez rfcomm problem, potential
	bug?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <4322E012.1070701@telia.com>
References: <4322E012.1070701@telia.com>
Content-Type: text/plain
Message-Id: <1126359742.31313.7.camel@blade>
Mime-Version: 1.0
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
Date: Sat, 10 Sep 2005 15:42:22 +0200

Hi Mikael,

> Can anyone from the developer team look at 
> http://sourceforge.net/mailarchive/forum.php?thread_id=8154927&forum_id=1883 
> ?
> 
> I am suspecting it is a potential bug in either the phone or the 
> software. Yet I am not qualified enough in the area to judge which. I 
> did try out  Seba T.'s suggestion yet the reply was placed as a new 
> thread (for some reason) at 
> http://sourceforge.net/mailarchive/forum.php?thread_id=8159796&forum_id=1883.

it is a good idea to check with sdptool to which RFCOMM channel the DUN
profile is attached. However you can also send me the phone and I try to
fix it or at least create a workaround.

Regards

Marcel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
