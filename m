Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] D-Bus support
From: Marcel Holtmann <marcel@holtmann.org>
To: Fredrik Noring <noring@nocrew.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076274445.14742.73.camel@akka.yeti.nocrew.org>
References: <1076265358.2670.36.camel@pegasus>
	 <1076266267.14742.38.camel@akka.yeti.nocrew.org>
	 <1076267396.2670.58.camel@pegasus>
	 <1076274445.14742.73.camel@akka.yeti.nocrew.org>
Content-Type: text/plain
Message-Id: <1076277892.6869.39.camel@pegasus>
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
Date: Sun, 08 Feb 2004 23:04:53 +0100

Hi Fredrik,

> > My favourite storage is Berkeley DB.
> 
> That's an interesting idea, you mentioned that before. Can you
> elaborate, please? 

This is my favourite and we should make it easy to substitute is with
another storage backend. So the handheld or embedded people can use what
they thing fits better.

> Here are some advantages of using textfiles (as default) for hcid
> storage:
> 
>    1. Textfiles are intuitive to use and debug because they work
>       with any tool (emacs, grep, awk, perl etc.)
> 
>    2. Small to medium size storage files have always been text
>       files in Unix/Linux (/etc/passwd, /etc/hosts etc.)
> 
>    3. Textfile routines are very lightweight and efficient.

If we have a D-Bus interface, these files (databases) should only be
modified by the hcid. It is easier to use the Berkeley DB, because you
don't have to write everything by yourself. The database code includes
locking stuff for free.

My idea is to have a plain text file for default configuration and a
database file with dynamic configuration.

	/etc/bluetooth/hcid.conf
	/etc/bluetooth/hcid.db

The "hcid.db" will store different databases in the same file, for
example link keys or devices names.

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
