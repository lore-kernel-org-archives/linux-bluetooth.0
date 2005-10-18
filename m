Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] Changes to Inquiry D-BUS method
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20051017195943.GA5200@localhost.localdomain>
References: <20051017195943.GA5200@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1129656858.10721.42.camel@localhost.localdomain>
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
Date: Tue, 18 Oct 2005 19:34:18 +0200

Hi Johan,

> A major problem with the current Inquiry D-BUS method implementation is
> that it blocks while the inquiry is in progress. What this means is that
> e.g. InquiryResult signals aren't sent until the inquiry process
> finishes.
> 
> I think that the easiest and cleanest way to solve this is to not return
> the inquiry results in the D-BUS method return, but have the user listen
> to the InquiryResult signals that hcid already emmits. The attached
> patch does this change.

the patch is applied and this is how this should work. We maybe need an
extra method to get the inquiry cache or a list of previous seen
devices.

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
