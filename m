Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: RE: [Bluez-users] DB aliases (wishlist)
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: EXT-Somil.Asthana@nokia.com
Cc: Max Krasnyansky <maxk@qualcomm.com>, tomi@virago.in-chemnitz.de, BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: 
	<E320A8529CF07E4C967ECC2F380B0CF9013E84C7@bsebe001.americas.nokia.com>
References: 
	<E320A8529CF07E4C967ECC2F380B0CF9013E84C7@bsebe001.americas.nokia.com>
Content-Type: text/plain
Message-Id: <1049985158.7671.25.camel@pegasus.local>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: 10 Apr 2003 16:32:31 +0200

Hi Somil,

>   Just a thought !! Do you really think this is necessary feature because I added a simple cmd in hcitool -i hciX lname <local_name> which calls issues HCI_CMD to write local name. It was nothing more than cut & paste from hcid/main.c file which writes local name...

we don't need this, because you can use

	hciconfig hci0 name <local-name>

and I don't see what this have to do with the mail from Paul. Such an
aliases, hosts or devices file is for the remote devices, not the local
ones.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
