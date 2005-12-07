Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4396F9AD.9020203@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Bluetooth Voice Setting
References: <HCEOIFALKKLBLJPENPNOKEGGCAAA.khaled@ipbill.com> <4396F636.4020400@csr.com>
In-Reply-To: <4396F636.4020400@csr.com>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Wed, 07 Dec 2005 08:03:09 -0700

Khaled,

Run "hciconfig hci0 revision" as root and show us the output.

Also see http://bluetooth-alsa.sourceforge.net/index.html#help

Brad

Steven Singer wrote:
> There are no SCO packets in the trace. Ar you sure your module is set
> to route SCO over HCI (as opposed to over a PCM port). hciconfig
> revision should tell you. You should also do hciconfig -a.
> 
> It may be that the other side has got upset that the SCO link is up
> and it's connected to the remote side, but there has been no SCO data.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
