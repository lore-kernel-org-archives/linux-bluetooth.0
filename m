Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <403B95A0.8080203@superbug.demon.co.uk>
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: Ibrahim El-Shafei <shaffei@softhome.net>
CC: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] bluepin error
References: <1077275969.1396.8.camel@shafei.eth>
In-Reply-To: <1077275969.1396.8.camel@shafei.eth>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Tue, 24 Feb 2004 18:19:12 +0000

Ibrahim El-Shafei wrote:
> Dear Sir,
> 
> I'm trying to run the bluepin command but I receive an error saying
> GtkDialog not defined.
> 
> I've checked the python script at line 39 but I see that everything is
> ok.
> 
> Another question: Do I type --> bluepin /etc/bluetooth/pin devicename?
> or deviceaddress?
> 
> Thank you for your help in advance.
> 
> Best regards,

http://bluez.sourceforge.net/download/bluepin

Overwrite /usr/bin/bluepin with it and don't edit /etc/bluetooth/pin

The problem is dependent on which gtk version you have.
Older versions of gtk use GtkDialog, newer versions use gtk.Dialog

Cheers
James


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
