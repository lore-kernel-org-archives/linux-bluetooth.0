Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Rfcomm Use Count
From: Marcel Holtmann <marcel@holtmann.org>
To: diego.liziero@unimore.it
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <1096471423.20392.444.camel@igno>
References: <001d01c4a02c$9aaeab00$1a01010a@baked>
	 <1095851321.6223.15.camel@pegasus>  <1095861229.6223.32.camel@pegasus>
	 <1096471423.20392.444.camel@igno>
Content-Type: text/plain
Message-Id: <1096709172.4809.17.camel@notepaq>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 02 Oct 2004 11:26:12 +0200

Hi Diego,

> I had the same problem here.
> 
> The patch seems to solve it.
> 
> Tested rfcomm on linux 2.6 single processor.
> 
> I tried to apply the fix also to 2.4.x with
> the following patch that compiles.
> 
> I hope it is correct.
> 
> Thanks for your work.

I will do a patch for 2.4 when I resynced every pending 2.6 stuff. At
the moment I am not quite sure that even my 2.6 patch is the best
solution. However it is better then nothing.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
