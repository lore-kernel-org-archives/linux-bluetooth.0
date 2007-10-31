Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20071031134512.45b2d41a.vientito1@pppoe.ca>
References: <20071031134512.45b2d41a.vientito1@pppoe.ca>
Date: Wed, 31 Oct 2007 18:49:50 +0100
Message-Id: <1193852990.32459.87.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] here's the log i retrieve for Error 22
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

> syslog shows this:
> 
>  Bluetooth Audio daemon
> Oct 31 13:38:06 billy audio[15847]: /etc/bluetooth/audio.conf: /etc/bluetooth/audio.conf: key Enable not found
> Oct 31 13:38:06 billy audio[15847]: /etc/bluetooth/audio.conf: /etc/bluetooth/audio.conf: key Disable not found
> Oct 31 13:38:06 billy audio[15847]: /etc/bluetooth/audio.conf: /etc/bluetooth/audio.conf: group A2DP not found
> Oct 31 13:38:06 billy audio[15847]: Config options: DisableHFP=true, SCORouting=PCM, SourceCount=1
> Oct 31 13:38:06 billy audio[15847]: Unix socket created: 5
> Oct 31 13:38:06 billy audio[15847]: add_service_record: got record id 0x10000
> Oct 31 13:38:06 billy audio[15847]: add_service_record: got record id 0x10001
> Oct 31 13:38:06 billy audio[15847]: Registered manager path:/org/bluez/audio
> Oct 31 13:38:06 billy audio[15847]: Loading device 00:13:17:F2:30:25 (headset )
> Oct 31 13:38:06 billy audio[15847]: Got path /org/bluez/hci0 for adapter with address 00:02:72:02:3F:9E
> Oct 31 13:38:06 billy audio[15847]: Selecting default device
> Oct 31 13:38:06 billy audio[15847]: Setting 00:13:17:F2:30:25 as default device
> Oct 31 13:39:08 billy audio[15847]: Accepted new client connection on unix socket (fd=8)
> Oct 31 13:39:08 billy audio[15847]: Package PKT_TYPE_CFG_REQ:0
> Oct 31 13:39:08 billy audio[15847]: State changed /org/bluez/audio/device0: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
> Oct 31 13:39:11 billy audio[15847]: get_handles_reply: Unable to get handle array from reply

this error is pretty clear and the hcidump confirms it. You device
doesn't support the headset profile.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
