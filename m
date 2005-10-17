Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [DBUS-PATCH] cleanup
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0510140703t4080f782o8fcdef057fa00c06@mail.gmail.com>
References: <e1effdeb0510140703t4080f782o8fcdef057fa00c06@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1129541712.24835.59.camel@blade>
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
Date: Mon, 17 Oct 2005 11:35:12 +0200

Hi Claudio,

> Minor changes:
>  - removed some logs
>  - added verification for dbus_connection_list_registered function. It
> can return FALSE if there is no memory to allocate the child entries

the patch is now in the CVS. The whitespace thing is getting better and
I hope you use an editor that is visualizing them for you.

There are some programming styles in the code that we need to change,
because this code is getting ugly otherwise. Here is a bad example:

void func(void)
{
	if (test) {
		do_something();
	}
}

This will end up in nesting statements and you have to indent to deep to
keep it readable somehow. So the preferred way is:

void func(void)
{
	if (!test)
		return;

	do_something();
}

If a function is some lines longer this is not a big problem for the
understanding of the code, but if it is indented to deep then the code
becomes hard to read.

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
