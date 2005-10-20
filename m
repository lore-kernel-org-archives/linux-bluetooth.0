Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [DBUS-PATCH] cleanup
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1129541712.24835.59.camel@blade>
References: <e1effdeb0510140703t4080f782o8fcdef057fa00c06@mail.gmail.com>
	 <1129541712.24835.59.camel@blade>
Content-Type: text/plain
Message-Id: <1129799276.2241.39.camel@blade>
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
Date: Thu, 20 Oct 2005 11:07:56 +0200

Hi Claudio,

> There are some programming styles in the code that we need to change,
> because this code is getting ugly otherwise.

here are some more coding style things I like to see. This is the bad
example:

	for (i = 0; i < 10; i++) {
		if (test_something()) {
			do_something();
		}
	}

This will end up in some very nested loops. So the better way to write
it is this:

	for (i = 0; i < 10; i++) {
		if (!test_something())
			continue;

		do_something();
	}

Please keep these things in mind when coding. It will make it a lot more
readable and understandable for outsiders.

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
