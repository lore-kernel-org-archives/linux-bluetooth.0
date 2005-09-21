Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <9307f5f205092106191197c374@mail.gmail.com>
From: "P. Durante" <shackan@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] hcid D-Bus patch
In-Reply-To: <e1effdeb05092105492fce2ff2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e1effdeb05091607426f824afa@mail.gmail.com>
	 <1127292701.495.11.camel@localhost.localdomain>
	 <e1effdeb05092105492fce2ff2@mail.gmail.com>
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
Date: Wed, 21 Sep 2005 15:19:51 +0200

Hi,

>  org.bluez.hci.error.Failed  /* here we can add the bluetooth error code =
*/

Just an idea, keep it simple, if you give the clients just the
bluetooth error code they'll have to decode its meaning using
something like strerror( bt_error( error_code )) every time they make
a request, quite boring, even worse, bt_error is bluez-specific and if
the client wants to use something like that in a language which is not
C, they should grab the bluetooth specification write their own
function which tells what each error code means...

or

since dbus errors consist of error_name + error_message you could put
something meaningful in the error_message, and eventually append an
additional field with the error code to the message as well ( if the
application wants to treat some error codes in a particular way ) this
seems ok with the dbus specification which only says (if I remember
correctly) that if the first field in an error message is of type
'string' that string will be treated as the error message, and doesn't
say anything about additional fields.

regards


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
