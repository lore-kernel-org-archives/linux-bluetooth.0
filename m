Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <424C259C.9000201@futurlink.com>
From: Pedro Monjo Florit <pedro.monjo@futurlink.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] malloc & free
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 31 Mar 2005 18:30:20 +0200

Hi Marcel!

In the application I am developing, I want to log some information about 
Bluetooth devices, pretty much like "sdptool browse" and "hcitool info" 
do. In the code of these applications, there are calls to some library 
functions like hci_dflagstostr(), hci_lmtostr()... that create a string 
with information about the device (flags, features, etc.).

The problem with these functions is that they call malloc(), expecting 
the caller to call free(). The problem with that is that this approach 
is not save, as it is not guaranteed that calling malloc() in a library 
function and free() in the main program works. In fact, I have seen a 
segmentation fault doing that.

AFAIK, there are two alternatives: either the library functions expect a 
buffer (and its size) to be filled or malloc() and free() are both done 
within the library, which means creating a new library function call for 
freeing buffers allocated with malloc(). Are any of this alternatives 
implemented or on the roadmap? What workaround do you suggest?

Thanks,

Pedro Monjo


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
