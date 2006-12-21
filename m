Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <1ea281660612210707y5bd1733cl85ebbae2565a6118@mail.gmail.com>
Date: Thu, 21 Dec 2006 16:07:21 +0100
From: "=?ISO-8859-1?Q?St=E5le_Andreas_Kleppe?=" <staale.kleppe@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1166705327.9307.2.camel@violet>
MIME-Version: 1.0
References: <332f27270612210445n276dafbevf29f0d49c0c51d4f@mail.gmail.com>
	<1166705327.9307.2.camel@violet>
Subject: Re: [Bluez-users] Delete,
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
Content-Type: multipart/mixed; boundary="===============0482670531=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0482670531==
Content-Type: multipart/alternative;
	boundary="----=_Part_25971_23986263.1166713641283"

------=_Part_25971_23986263.1166713641283
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 12/21/06, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Stale,
>
> > Working on my Master's I want to be able to delete, write and read the
> > link keys associated with a paired device. I found the functions
> >
> > int hci_read_stored_link_key(int dd, bdaddr_t *bdaddr, uint8_t all,
> > int to)
> > int hci_write_stored_link_key(int dd, bdaddr_t *bdaddr, uint8_t *key,
> > int to)
> > int hci_delete_stored_link_key(int dd, bdaddr_t *bdaddr, uint8_t all,
> > int to)
> >
> > in hci.c and tried to use the delete-function. It seems to work, as
> > the function call returns 0, indicating that no problems occured.
> > However, the link key still appears
> > in /var/libs/bluetooth/BD_ADDR/linkkeys, and a following
> > authentication is still successfull.
> > Hcidump reports this:
> > < HCI Command: Delete Stored Link Key (0x03|0x0012) plen 7
> >     bdaddr 00:09:DD:60:02:45 all 0
> > > HCI Event: Command Complete (0x0e) plen 4
> >     Delete Stored Link Key (0x03|0x0012) ncmd 1
> >     status 0x11 deleted 2525
> >     Error: Unsupported Feature or Parameter Value
> >
> > I guess it might be the value of parameter "all". I didn't know what
> > it is, so I tried with 0 and 1 (apperently not correct). Anyone knows
> > what this parameter of type uint8_t is for? I thought it might be like
> > a "boolean" variable, instructing deletion of ALL the associated link
> > keys. Am I far off?
> >
> > Another thing, about the hci_read_stored_link_key function. Is the key
> > returned as an int-value or by some other means? I'm a bit confused
> > about this matter..
>
> all these functions deal with the link keys stored on the chip. The
> default operation of BlueZ is not to store these link keys on the
> Bluetooth chip itself. Have a look at the D-Bus API for BlueZ. The
> methods ListBondings() and RemoveBonding() give you what you actually
> need.
>
> Regards
>
> Marcel


Thank you so much! Really appreciate it!
You have no idea how long I've been trying to solve this one! I'll take a
look at D-Bus.

Regards

Staale

------=_Part_25971_23986263.1166713641283
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">On 12/21/06, <b class="gmail_sendername">Marcel Holtmann</b> &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Stale,<br><br>&gt; Working on my Master&#39;s I want to be able to delete, write and read the<br>&gt; link keys associated with a paired device. I found the functions<br>&gt;<br>&gt; int hci_read_stored_link_key(int dd, bdaddr_t *bdaddr, uint8_t all,
<br>&gt; int to)<br>&gt; int hci_write_stored_link_key(int dd, bdaddr_t *bdaddr, uint8_t *key,<br>&gt; int to)<br>&gt; int hci_delete_stored_link_key(int dd, bdaddr_t *bdaddr, uint8_t all,<br>&gt; int to)<br>&gt;<br>&gt; in 
hci.c and tried to use the delete-function. It seems to work, as<br>&gt; the function call returns 0, indicating that no problems occured.<br>&gt; However, the link key still appears<br>&gt; in /var/libs/bluetooth/BD_ADDR/linkkeys, and a following
<br>&gt; authentication is still successfull.<br>&gt; Hcidump reports this:<br>&gt; &lt; HCI Command: Delete Stored Link Key (0x03|0x0012) plen 7<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; bdaddr 00:09:DD:60:02:45 all 0<br>&gt; &gt; HCI Event: Command Complete (0x0e) plen 4
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Delete Stored Link Key (0x03|0x0012) ncmd 1<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; status 0x11 deleted 2525<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Error: Unsupported Feature or Parameter Value<br>&gt;<br>&gt; I guess it might be the value of parameter &quot;all&quot;. I didn&#39;t know what
<br>&gt; it is, so I tried with 0 and 1 (apperently not correct). Anyone knows<br>&gt; what this parameter of type uint8_t is for? I thought it might be like<br>&gt; a &quot;boolean&quot; variable, instructing deletion of ALL the associated link
<br>&gt; keys. Am I far off?<br>&gt;<br>&gt; Another thing, about the hci_read_stored_link_key function. Is the key<br>&gt; returned as an int-value or by some other means? I&#39;m a bit confused<br>&gt; about this matter..
<br><br>all these functions deal with the link keys stored on the chip. The<br>default operation of BlueZ is not to store these link keys on the<br>Bluetooth chip itself. Have a look at the D-Bus API for BlueZ. The<br>methods ListBondings() and RemoveBonding() give you what you actually
<br>need.<br><br>Regards<br><br>Marcel</blockquote><div><br>Thank you so much! Really appreciate it! <br>You have no idea how long I&#39;ve been trying to solve this one! I&#39;ll take a look at D-Bus.<br><br>Regards<br><br>
Staale<br></div><br></div><br>

------=_Part_25971_23986263.1166713641283--


--===============0482670531==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0482670531==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0482670531==--
