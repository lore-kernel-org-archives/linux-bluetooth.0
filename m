Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Cannot send through serial device rfcomm
From: Marcel Holtmann <marcel@holtmann.org>
To: Robert Wlaschin <robertw@healthhero.com>
Cc: "'bluez-devel@lists.sourceforge.net'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <CBBBD909D2D6D211B4700090273F9E6E04C49A6B@polaris.hhn.com>
References: <CBBBD909D2D6D211B4700090273F9E6E04C49A6B@polaris.hhn.com>
Content-Type: text/plain
Message-Id: <1128485442.26362.29.camel@blade>
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
Date: Wed, 05 Oct 2005 06:10:42 +0200

Hi Robert,

> That was a good suggestion.  I've seen usage of those programs on
> various help/websites.
> 
> Due to a hardware limitations, I only have microcom available which
> seems flaky at best.  I seem to be getting the 'Exitcode 2 - cannot
> open device /dev/rfcomm0' error message.  But I have tried opening a
> standard serial connection with microcom and it does function.
> 
> The code in attest should work given the method I am using, is this
> correct?  If so I can just rewrite it to something ... a little more
> towards my purpose.

check if the /dev/rfcomm0 device node has been created and if yes, then
run "hcidump -X -V" to see why the RFCOMM channel can't be opened.

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
