Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] rfcomm question 3
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <4204C77D.1040207@gmx.ch>
References: <20050205124828.1758.qmail@web60903.mail.yahoo.com>
	 <4204C77D.1040207@gmx.ch>
Content-Type: text/plain
Message-Id: <1107611491.6921.133.camel@pegasus>
Mime-Version: 1.0
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
Date: Sat, 05 Feb 2005 14:51:31 +0100

Hi Marco,

> Maybe this helps:
> 
> ---- start code snippet ----
> // handle the includes yourself
> 
> #define CHANNEL 4
> #define QUEUE 10
> 
> int main()
> {
> 	int sock, client;
> 	socklen_t alen;
> 	struct sockaddr_rc addr;
> 
> 	addr.rc_family = AF_BLUETOOTH;
> 	bacpy(&addr.rc_bdaddr, BDADDR_ANY);
> 	addr.rc_channel = htobs(CHANNEL);

thanks for the example, but the htobs(CHANNEL) is wrong. rc_channel is
only uint8_t and when you do byteswap on a big endian machine this will
end up in channel 0.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
