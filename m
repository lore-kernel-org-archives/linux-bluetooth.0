Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hcid patch (patch 00.13)
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0510060731s191b17bbrd52897af77622ba6@mail.gmail.com>
References: <e1effdeb0510060731s191b17bbrd52897af77622ba6@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1128784148.5212.17.camel@blade>
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
Date: Sat, 08 Oct 2005 17:09:08 +0200

Hi Claudio,

> What was the final decision about the path name? 

There is non at the moment.

> I read the e-mails exchanged in the D-Bus mailing list. Due the
> instability/side-effects of the  support '-' for path
> names, I think is not a good idea support it. I will keep the "hci"
> device name in the path until we find a good solution.

No problem. We will adjust it later.

> Do you have any suggestions or changes before integrate this code?

I applied this patch to my local tree and now I have to clean it up. You
should really follow my advises on tabs, whitespaces etc. A good idea is
to use an editor that will visualize tabs and whitespaces for you.

Can you provide hcid.conf security settings file for the current
services?

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
