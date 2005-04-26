Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <426E6857.6010204@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: a2play code that is working
References: <20050426122127.57962.qmail@web8302.mail.in.yahoo.com> <1114527365.10706.288.camel@pegasus>
In-Reply-To: <1114527365.10706.288.camel@pegasus>
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
Date: Tue, 26 Apr 2005 10:12:07 -0600

Marcel

> Now commenting on the change itself. The "struct sbc_frame_header"
> should not placed inside the sbc.h header file. This is the API
> interface and we don't need a definition of the SBC file format there.
> If you wanna modify the additional SBC parameters add them to sbc_struct
> and set them there. Please fix this.
> 
> Also a library should not use printf() at all. Remove them and improve
> the return values to match -ENOMEM etc.

I will clean this up (I was being lazy and rolling in submissions 
without reworking them enough)

Brad


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
