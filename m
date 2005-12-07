Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4396F636.4020400@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Bluetooth Voice Setting
References: <HCEOIFALKKLBLJPENPNOKEGGCAAA.khaled@ipbill.com>
In-Reply-To: <HCEOIFALKKLBLJPENPNOKEGGCAAA.khaled@ipbill.com>
Content-Type: text/plain; charset=us-ascii
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
Date: Wed, 07 Dec 2005 14:48:22 +0000

Khaled wrote:
> From the following I understand that once the SCO link is established (when
> a phone call is made), HV3 SCO packets are transmitted with voice data, but
> then what do the subsequent mean? I assume they are incoming HV3 packets?

They're not SCO packets. They're RFCOMM packets. There are no SCO
packets on the trace.

At the AT command level, the sequence is (with explanation):

  < \r\nATD0208xxxxx13;\r\n  ; dial number (I've x'd out the number)
  > \r\nOK\r\n               ; ok, will do
  > \r\n+CIEV: 3,2\r\n       ; outgoing call setup in progress
  [SCO link created at HCI]
  > \r\n+CIEV: 3,3\r\n       ; remote party alerted
  > \r\n+CIEV: 1,1\r\n       ; call active
  > \r\n+CIEV: 3,0\r\n       ; no longer in call setup (now in call)
  > \r\nERROR\r\n            ; something went wrong
  > \r\n+CIEV: 1,0\r\n       ; call inactive
  < \r\nAT+CHUP\r\n.         ; hangup
  [SCO link disconnect started at HCI]
  > \r\nOK\r\n               ; ok
  [SCO link disconnect completes at HCI]

It's worth noting that the local device splits AT messages across
multiple RFCOMM frames. This is perfectly legal as RFCOMM is a byte
stream not a packet stream so packet boundaries are meaningless [1].

The key message is the "+CIEV: 1,0" from the other side. This indicates
that the call has been dropped. The spec seems to imply that this in
itself is sufficient for headset to know that the call has been
dropped and that the AT+CHUP message is used only when the headset
wants to initiate the disconnection. However, by this point the call
is already down so it can't hurt.

Presumably the preceeding "ERROR" indication is related. Unfortunately,
it's not possible to tell what went wrong. All the spec says is:

  * ERROR

    Standard error indication code. It shall be issued on detection of
    any syntax, format or procedure error condition. [...]

Everything before the ERROR message exactly matches the reference
message sequence chart in the spec.

There are no SCO packets in the trace. Ar you sure your module is set
to route SCO over HCI (as opposed to over a PCM port). hciconfig
revision should tell you. You should also do hciconfig -a.

It may be that the other side has got upset that the SCO link is up
and it's connected to the remote side, but there has been no SCO data.

	- Steven

[1] Although it should be worth noting that certain very old headset/
    Audio gateway implementations incorrectly expected AT commands to
    come in a single RFCOMM frame. This doesn't appear to be anything
    to do with what's happening here, I mention it merely for future
    reference.
-- 


This message has been scanned for viruses by BlackSpider MailControl - www.blackspider.com


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
