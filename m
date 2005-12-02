Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <94e407f00512020222g42375059h491249e313cea536@mail.gmail.com>
From: Arpit Rai <whalesurf@gmail.com>
To: bluez-users@lists.sourceforge.net
Cc: eng11084@nus.edu.sg
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_21858_25404749.1133518950618"
Subject: [Bluez-users] Definition of hci_conn_info_req
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
Date: Fri, 2 Dec 2005 18:22:30 +0800

------=_Part_21858_25404749.1133518950618
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi

Another basic question.The statement below is a request to establish
connection with a remote device,right?

struct hci_conn_info_req *cr;
cr =3D malloc(sizeof(*cr) + sizeof(struct hci_conn_info));

Now,is &cr->bdaddr supposed to be the remote device bluetooth address?

When I convert this value to string and output it, it doesn't give me the
correct value for the remote bluetooth device. It returns 08:04:9A:AC:00:00=
.
Doesn't make sense to me.

Regards
 Arpit

------=_Part_21858_25404749.1133518950618
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi <br>

<br>

Another basic question.The statement below is a request to establish connec=
tion with a remote device,right?<br>

<br>

struct hci_conn_info_req *cr;<br>

cr =3D malloc(sizeof(*cr) + sizeof(struct hci_conn_info));<br>

<br>

Now,is &amp;cr-&gt;bdaddr supposed to be the remote device bluetooth addres=
s?<br>

<br>

When I convert this value to string and output it, it doesn't give me
the correct value for the remote bluetooth device. It returns
08:04:9A:AC:00:00. Doesn't make sense to me.<br>

<br>

Regards<br>
<span class=3D"sg">
Arpit</span>

------=_Part_21858_25404749.1133518950618--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
