Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <332f27270612210445n276dafbevf29f0d49c0c51d4f@mail.gmail.com>
Date: Thu, 21 Dec 2006 13:45:17 +0100
From: "Staale A. Kleppe" <stale.kleppe@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Delete,
	write and read link keys using functions in hci.c
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0801940715=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0801940715==
Content-Type: multipart/alternative;
	boundary="----=_Part_32052_2872036.1166705117753"

------=_Part_32052_2872036.1166705117753
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Good atfernoon (or morning depending on your whereabouts)!

Working on my Master's I want to be able to delete, write and read the link
keys associated with a paired device. I found the functions

int hci_read_stored_link_key(int dd, bdaddr_t *bdaddr, uint8_t all, int to)
int hci_write_stored_link_key(int dd, bdaddr_t *bdaddr, uint8_t *key, int
to)
int hci_delete_stored_link_key(int dd, bdaddr_t *bdaddr, uint8_t all, int
to)

in hci.c and tried to use the delete-function. It seems to work, as the
function call returns 0, indicating that no problems occured. However, the
link key still appears in /var/libs/bluetooth/BD_ADDR/linkkeys, and a
following authentication is still successfull.
Hcidump reports this:
< HCI Command: Delete Stored Link Key (0x03|0x0012) plen 7
    bdaddr 00:09:DD:60:02:45 all 0
> HCI Event: Command Complete (0x0e) plen 4
    Delete Stored Link Key (0x03|0x0012) ncmd 1
    status 0x11 deleted 2525
    Error: Unsupported Feature or Parameter Value

I guess it might be the value of parameter "all". I didn't know what it is,
so I tried with 0 and 1 (apperently not correct). Anyone knows what this
parameter of type uint8_t is for? I thought it might be like a "boolean"
variable, instructing deletion of ALL the associated link keys. Am I far
off?

Another thing, about the hci_read_stored_link_key function. Is the key
returned as an int-value or by some other means? I'm a bit confused about
this matter..

Any reply will be valued greetly.

Regards,
Staale A. Kleppe

------=_Part_32052_2872036.1166705117753
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Good atfernoon (or morning depending on your whereabouts)!<br><br>Working on my Master&#39;s I want to be able to delete, write and read the link keys associated with a paired device. I found the functions <br><br>int hci_read_stored_link_key(int dd, bdaddr_t *bdaddr, uint8_t all, int to)
<br>int hci_write_stored_link_key(int dd, bdaddr_t *bdaddr, uint8_t *key, int to)<br>int hci_delete_stored_link_key(int dd, bdaddr_t *bdaddr, uint8_t all, int to)<br><br>in hci.c and tried to use the delete-function. It seems to work, as the function call returns 0, indicating that no problems occured. However, the link key still appears in /var/libs/bluetooth/BD_ADDR/linkkeys, and a following authentication is still successfull. 
<br>Hcidump reports this:<br>&lt; HCI Command: Delete Stored Link Key (0x03|0x0012) plen 7<br>&nbsp;&nbsp;&nbsp; bdaddr 00:09:DD:60:02:45 all 0<br>&gt; HCI Event: Command Complete (0x0e) plen 4<br>&nbsp;&nbsp;&nbsp; Delete Stored Link Key (0x03|0x0012) ncmd 1
<br>&nbsp;&nbsp;&nbsp; status 0x11 deleted 2525<br>&nbsp;&nbsp;&nbsp; Error: Unsupported Feature or Parameter Value<br><br>I guess it might be the value of parameter &quot;all&quot;. I didn&#39;t know what it is, so I tried with 0 and 1 (apperently not correct). Anyone knows what this parameter of type uint8_t is for? I thought it might be like a &quot;boolean&quot; variable, instructing deletion of ALL the associated link keys. Am I far off?
<br><br>Another thing, about the hci_read_stored_link_key function. Is the key returned as an int-value or by some other means? I&#39;m a bit confused about this matter.. <br><br>Any reply will be valued greetly.<br><br>Regards,
<br>Staale A. Kleppe<br><br><br>

------=_Part_32052_2872036.1166705117753--


--===============0801940715==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0801940715==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0801940715==--
