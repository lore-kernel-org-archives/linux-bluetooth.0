Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Andreas Gaufer <Andreas.Gaufer@blue-cell-networks.com>
To: Bluez Devel <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hcitool con list incomplete (was: Connect Complete with Status 09)
Message-Id: <20040610121805.3121ca26.Andreas.Gaufer@blue-cell-networks.com>
In-Reply-To: <20040609212529.6901de52.Andreas.Gaufer@blue-cell-networks.com>
References: <20040609185348.65a9f382.Andreas.Gaufer@blue-cell-networks.com>
	<40C74EDD.6060903@csr.com>
	<20040609212529.6901de52.Andreas.Gaufer@blue-cell-networks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Date: Thu, 10 Jun 2004 12:18:05 +0200

Hi,

I dug in a little bit deeper last night and i think its not a problem of the 
chip. The list that is printed out by "hcitool con" is incomplete in certain 
situations. This leads to various problems with many tools because they try to
connect again witch fails.

If a "create connection" is issiued while there is already a connection the chip
returnes a Connect Complete with status 0x0B witch is absolutely right. The
problem is that the hanlde of the "hcitool con" list is removed but the chip
still keeps it, witch is good behaviour in my opinion. It can be disconected with 
"hcitool cmd".

Who or what is keeping this list?

Greetings

Andreas Gaufer


-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
