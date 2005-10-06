Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bluetooth issues with 2.4.19 kernel.
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <4344F97C.5010206@ncoretech.com>
References: <4344EF00.1000404@ncoretech.com>
	 <1128592785.5492.22.camel@localhost.localdomain>
	 <4344F97C.5010206@ncoretech.com>
Content-Type: text/plain
Message-Id: <1128593655.5492.32.camel@localhost.localdomain>
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
Date: Thu, 06 Oct 2005 12:14:15 +0200

Hi Zaheer,

> I am having other issues with 2.6 we haven't started working on it yet, 
> and getting Bluetooth working on 2.4.19 will solve all my issues.
> Hope you understand. This is for an immediate requirement put by  a 
> customer.
> Request you guys to please come up with any solution.

please understand that nobody pays me for working on BlueZ and so I
don't think that I will spend my rare freetime to please a costumer of
you. I am happy to help you to resolve any issue based on a 2.6 kernel,
but the 2.4 series has been closed a long time ago.

However you might find others to help you. So include the output of
"hciconfig -a" and "hcidump -X -V". Also make sure that you run the
latest versions of the BlueZ library, utils etc.

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
