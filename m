Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Nokia 770 and bluetooth audio
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <4346F84D.8050004@xmission.com>
References: <4346F84D.8050004@xmission.com>
Content-Type: text/plain
Message-Id: <1128774836.5212.4.camel@blade>
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
Date: Sat, 08 Oct 2005 14:33:56 +0200

Hi Brad,

> Has Nokia gotten a dev unit to Marcel or anyone? I think the biggest 
> missing piece with this awesome little device will be bluetooth audio. 
> Unfortunately it will be a step back in terms of polish and convenience 
> from symbian since we're basically still working with prototype audio 
> drivers in linux.
> 
> Has Nokia promised bluetooth audio when they deliver voip next year? 
> They'd be a great partner for straightening things out in our drivers...

if I am not mistaken, then the integration into GStreamer will solve all
the problems. However we need a good SBC encoder for this first. May you
wanna give an update on its current status.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
