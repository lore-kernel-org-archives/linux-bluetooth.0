Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Device specific configuration
From: Marcel Holtmann <marcel@holtmann.org>
To: Fredrik Noring <noring@nocrew.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1075829711.25472.22.camel@kalkyl.roxen.com>
References: <1075827176.13285.82.camel@pegasus>
	 <1075829711.25472.22.camel@kalkyl.roxen.com>
Content-Type: text/plain
Message-Id: <1075834077.13285.108.camel@pegasus>
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
Date: Tue, 03 Feb 2004 19:47:58 +0100

Hi Fredrik,

> Here's a new draft for the hcid.1 man page. It includes a description of
> hcid.conf. I propose a few modifications, detailed in the the draft, all
> possible to make backwards compatible:
> 
>    1. Device and security settings in the "options" section becomes
>       deprecated and an alias in favour of "device default". These
>       parameters are default unless specified in the "device", "device
>       <hci>" and "device <bdaddr>" sections.
> 
>    2. "enable" and "disable" becomes deprecated and aliases for
>       "yes" and "no" respectively.

please don't include stuff that I haven't yet applied. The device
specific configuration will be applied, but I haven't decided on
anything else. BTW did my patch work fine for you?

What patch brings in "device default {..."? We don't need it, because we
can use "device {..." for it.

Name the tool "Bluetooth HCI daemon", because interface is to generic.

The mailing list is still "bluez-devel@lists.sf.net" and I don't tend to
change it, because the spam stuff of SF is doing a good job.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
