Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <473485D7.8080101@kernelconcepts.de>
Date: Fri, 09 Nov 2007 17:07:51 +0100
From: Nils Faerber <nils.faerber@kernelconcepts.de>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <47347AB3.30504@kernelconcepts.de>
	<d89ddf300711090727u3aa0b50bie97615df7c71d195@mail.gmail.com>
In-Reply-To: <d89ddf300711090727u3aa0b50bie97615df7c71d195@mail.gmail.com>
Subject: Re: [Bluez-devel] i.Tech Clip S38 - MP3 streaming?
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

Brad Midgley schrieb:
> Nils
Hi Brad!

>> I have one of those "i.Tech Clip S38" laying quite uselessly on my desk...
> I have a similar r35. mp3 is a different codec that you choose when
> negotiating the connection. I made the old a2play detect the codec but
> never did try to use it.

Ah, cool, that's what I thought...

> The right approach is to work with the gstreamer plugins inside
> bluez-utils so the codec negotiation happens the gst way. This way an
> mp3 stream would naturally choose the mp3 decoder as the optimal
> selection.

Uh, OK ;)
Yeah, nothing comes for free, so I will have to look into this.

Many thanks for your hints/advice!

Cheers
  nils faerber

-- 
kernel concepts GbR        Tel: +49-271-771091-12
Sieghuetter Hauptweg 48    Fax: +49-271-771091-19
D-57072 Siegen             Mob: +49-176-21024535
--

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
